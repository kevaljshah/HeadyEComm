//
//  Product.swift
//  HeadyEComm
//
//  Created by Keval Shah on 4/5/20.
//  Copyright © 2020 Keval Shah. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class Product: Object, Decodable {
    dynamic var id: Int = 0
    dynamic var name = ""
    dynamic var date_added = ""
    var tax: Tax? = nil
    let variants: List<Variant> = List<Variant>()
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case date_added
        case tax
        case variants
    }
    
    required init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        date_added = try container.decode(String.self, forKey: .date_added)
        
        tax = try container.decode(Tax.self, forKey: .tax)
        
        let variantsList = try container.decode([Variant].self, forKey: .variants)
        variants.append(objectsIn: variantsList)
        
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

@objcMembers class RankingProduct: Object, Decodable {
    dynamic var id: Int = 0
    dynamic var view_count = RealmOptional<Int>()
    dynamic var order_count = RealmOptional<Int>()
    dynamic var shares = RealmOptional<Int>()
    
    enum CodingKeys: String, CodingKey {
        case id
        case view_count
        case order_count
        case shares
    }
    
    required init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        if container.contains(.view_count) {
            view_count = try container.decode(RealmOptional<Int>.self, forKey: .view_count)
        }
        if container.contains(.order_count) {
            order_count = try container.decode(RealmOptional<Int>.self, forKey: .order_count)
        }
        if container.contains(.shares) {
            shares = try container.decode(RealmOptional<Int>.self, forKey: .shares)
        }
        
        super.init()
    }
    
    required init()
    {
        super.init()
    }
}
