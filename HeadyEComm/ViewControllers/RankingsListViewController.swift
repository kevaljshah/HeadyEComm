//
//  RankingsListViewController.swift
//  HeadyEComm
//
//  Created by Keval Shah on 4/6/20.
//  Copyright © 2020 Keval Shah. All rights reserved.
//

import UIKit

class RankingsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var index: Int = 0

    @IBOutlet weak var tableView: UITableView!
    var rankings: [Ranking] = []
    var products: [[RankingProduct]] = []
    let realm = RealmService.shared.realm
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
    }
    

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "rankingProduct" {
            if let destinationNavigationController = segue.destination as? UINavigationController,
            let targetController = destinationNavigationController.topViewController as? ProductViewController,
                let productIndex = tableView.indexPathForSelectedRow?.row
            {
                let product = realm.object(ofType: Product.self, forPrimaryKey: products[index][productIndex].id)!
                targetController.product = product
            }
        }
    }
 
    @IBAction func switchValue(_ sender: UISegmentedControl) {
        index = sender.selectedSegmentIndex
        tableView.reloadData()
    }
    
    public func setupData() {
        var viewedProducts: [RankingProduct] = []
        var orderedProducts: [RankingProduct] = []
        var sharedProducts: [RankingProduct] = []
        
        for ranking in rankings {
            for product in ranking.products {
                if product.view_count.value != nil {
                    viewedProducts.append(product)
                } else if product.order_count.value != nil {
                    orderedProducts.append(product)
                } else if product.shares.value != nil {
                    sharedProducts.append(product)
                }
            }
        }
        products.append(viewedProducts)
        products.append(orderedProducts)
        products.append(sharedProducts)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "rankingProduct", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products[index].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rankingCell", for: indexPath)
        let product = realm.object(ofType: Product.self, forPrimaryKey: products[index][indexPath.row].id)!
        cell.textLabel?.text = product.name
        switch index {
        case 0:
            if let viewCount = products[index][indexPath.row].view_count.value {
                cell.detailTextLabel?.text = "Views: \(String(describing: viewCount))"
            }
        case 1:
            if let orderCount = products[index][indexPath.row].order_count.value {
                cell.detailTextLabel?.text = "Orders: \(String(describing: orderCount))"
            }
        case 2:
            if let sharedCount = products[index][indexPath.row].shares.value {
                cell.detailTextLabel?.text = "Shares: \(String(describing: sharedCount))"
            }
        default:
            cell.detailTextLabel?.isHidden = true
        }
        return cell
    }
}
