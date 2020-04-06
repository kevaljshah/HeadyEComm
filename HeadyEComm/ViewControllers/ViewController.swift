//
//  ViewController.swift
//  HeadyEComm
//
//  Created by Keval Shah on 4/5/20.
//  Copyright © 2020 Keval Shah. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var categories: [Category] = []
    var categoryHeaders: [String] = []
    var subCategories: [[Category]] = []
    var mainCategories: [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storeModels()
    }
    
    func formData() {
        let realm = RealmService.shared.realm
        let categoryList = realm.objects(Category.self)
            categories = categoryList.filter { $0.child_categories.count > 0 && $0.id != 3 && $0.id != 11}
            mainCategories.append(realm.object(ofType: Category.self, forPrimaryKey: 3)!)
            mainCategories.append(realm.object(ofType: Category.self, forPrimaryKey: 11)!)
            
            for mainCategory in mainCategories {
                for category in categoryList {
                    var subCategoryList: [Category] = []
                    for i in 0..<category.child_categories.count {
                        subCategoryList.append(realm.object(ofType: Category.self, forPrimaryKey: category.child_categories[i])!)
                    }
                    if mainCategory.child_categories.contains(category.id) {
                        categoryHeaders.append("\(mainCategory.name): \(category.name)")
                        subCategories.append(subCategoryList)
                    }
                }
            }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subCategories[section].count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = categoryHeaders[section]
        label.backgroundColor = UIColor.systemOrange
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ecommerceCell", for: indexPath)
        
        cell.textLabel?.text = subCategories[indexPath.section][indexPath.row].name
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categoryHeaders.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showProductList", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showProductList" {
            if let destinationNavigationController = segue.destination as? UINavigationController,
            let targetController = destinationNavigationController.topViewController as? ProductsListViewController,
                let subcategoryIndex = tableView.indexPathForSelectedRow?.section,
                let productsIndex = tableView.indexPathForSelectedRow?.row
            {
                targetController.category = subCategories[subcategoryIndex][productsIndex]
            }
        } else if segue.identifier == "rankingList" {
            if let destinationNavigationController = segue.destination as? UINavigationController,
                let targetController = destinationNavigationController.topViewController as? RankingsListViewController {
                let rankingsList = RealmService.shared.realm.objects(Ranking.self)
                targetController.rankings = rankingsList.filter { $0.ranking != nil }
            }
        }
    }
    
    func storeModels()
    {
        guard let url = URL(string: "https://stark-spire-93433.herokuapp.com/json") else {
            return
        }
        
        do {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        
                        let inventory = try JSONDecoder().decode(Inventory.self, from: data)
                        let realm = try Realm()
                        try realm.write {
                            realm.add(inventory.categories, update: .modified)
                            realm.add(inventory.rankings, update: .modified)
                        }
                   } catch let error {
                      print(error)
                   }
                    DispatchQueue.main.async{
                        self.formData()
                        self.tableView.reloadData()
                    }
                }
            }.resume()
        }
    }
}

