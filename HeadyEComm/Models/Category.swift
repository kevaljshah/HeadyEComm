//
//  Category.swift
//  HeadyEComm
//
//  Created by Keval Shah on 4/5/20.
//  Copyright © 2020 Keval Shah. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class Category: Object, Decodable {
    dynamic var id: Int = 0
    dynamic var name = ""
    let products = List<Product>()
    let child_categories = List<Int>()
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case products
        case child_categories
    }
    
    required init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        
        let productsList = try container.decode([Product].self, forKey: .products)
        products.append(objectsIn: productsList)
        
        let categoriesList = try container.decode([Int].self, forKey: .child_categories)
        child_categories.append(objectsIn: categoriesList)
        
        super.init()
    }
    
    override class func primaryKey() -> String?
    {
        return "id"
    }
    
    required init()
    {
        super.init()
    }
}
