//
//  ProductsListCollectionViewCell.swift
//  HeadyEComm
//
//  Created by Keval Shah on 4/6/20.
//  Copyright © 2020 Keval Shah. All rights reserved.
//

import UIKit

class ProductsListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var variantLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    
    public func configure(with product: Product) {
        nameLabel.text = product.name
        variantLabel.text = "Variants: \(product.variants.count)"
        if let tax = product.tax {
            taxLabel.text = "\(tax.name): \(tax.value)"
        } else {
            taxLabel.isHidden = true
        }
    }
}
