//
//  ProductsListViewController.swift
//  HeadyEComm
//
//  Created by Keval Shah on 4/6/20.
//  Copyright © 2020 Keval Shah. All rights reserved.
//

import UIKit

private let reuseIdentifier = "productsListCell"

class ProductsListViewController: UICollectionViewController {
    
    var category: Category = Category()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showProduct" {
            if let destinationNavigationController = segue.destination as? UINavigationController,
            let targetController = destinationNavigationController.topViewController as? ProductViewController,
                let productIndex = collectionView.indexPathsForSelectedItems?.first?.row
            {
                targetController.product = category.products[productIndex]
            }
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return category.products.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProductsListCollectionViewCell
        cell.configure(with: category.products[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showProduct", sender: self)
    }
}
