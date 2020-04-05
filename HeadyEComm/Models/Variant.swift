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
    dynamic var size: Int? = nil
    dynamic var price: Int? = nil
    
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
        if let sizeValue = try container.decode(Int?.self, forKey: .size) {
            size = sizeValue
        }
        if let priceValue = try container.decode(Int?.self, forKey: .price) {
            price = priceValue
        }
        
        super.init()
    }
    
    required init()
    {
        super.init()
    }
}
