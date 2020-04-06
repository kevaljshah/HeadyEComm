//
//  Tax.swift
//  HeadyEComm
//
//  Created by Keval Shah on 4/5/20.
//  Copyright © 2020 Keval Shah. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class Tax: Object, Decodable {
    dynamic var name = ""
    dynamic var value: Float = 0
    
    enum CodingKeys: String, CodingKey {
        case name
        case value
    }
    
    required init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        value = try container.decode(Float.self, forKey: .value)
        
        super.init()
    }
    
    override class func primaryKey() -> String?
    {
        return "name"
    }
    
    required init()
    {
        super.init()
    }
}
