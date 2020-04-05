//
//  Inventory.swift
//  HeadyEComm
//
//  Created by Keval Shah on 4/5/20.
//  Copyright © 2020 Keval Shah. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class Inventory: Object, Decodable {
    dynamic var categories = List<Category>()
    dynamic var rankings = List<Ranking>()
    
    enum CodingKeys: String, CodingKey {
        case categories
        case rankings
    }
    
    required init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let categoriesList = try container.decode([Category].self, forKey: .categories)
        categories.append(objectsIn: categoriesList)
        
        let rankingsList = try container.decode([Ranking].self, forKey: .rankings)
        rankings.append(objectsIn: rankingsList)
        
        super.init()
    }
    
    required init()
    {
        super.init()
    }
}
