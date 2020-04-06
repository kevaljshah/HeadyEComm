//
//  ProductsCollectionViewCell.swift
//  HeadyEComm
//
//  Created by Keval Shah on 4/6/20.
//  Copyright © 2020 Keval Shah. All rights reserved.
//

import UIKit

class ProductsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    public func configure(with variant: Variant) {
        colorLabel.text = variant.color
        if let size = variant.size.value {
            sizeLabel.text = "Size: \(size)"
        } else {
            sizeLabel.isHidden = true
        }
        if let price = variant.price.value {
            priceLabel.text = "Price: \(price)"
        } else {
            priceLabel.isHidden = true
        }
    }
}
