//
//  Variant.swift
//  HeadyEComm
//
//  Created by Keval Shah on 4/5/20.
//  Copyright © 2020 Keval Shah. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class Variant: Object, Decodable {
    dynamic var id: Int = 0
    dynamic var color = ""
    dynamic var size = RealmOptional<Int>()
    dynamic var price = RealmOptional<Int>()
    
    enum CodingKeys: String, CodingKey {
        case id
        case color
        case size
        case price
    }
    
    required init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        color = try container.decode(String.self, forKey: .color)
        size = try container.decode(RealmOptional<Int>.self, forKey: .size)
        price = try container.decode(RealmOptional<Int>.self, forKey: .price)
        
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
