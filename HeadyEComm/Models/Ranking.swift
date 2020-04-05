//
//  Ranking.swift
//  HeadyEComm
//
//  Created by Keval Shah on 4/5/20.
//  Copyright © 2020 Keval Shah. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class Ranking: Object, Decodable {
    dynamic var ranking = ""
    let products = List<RankingProduct>()
    
    enum CodingKeys: String, CodingKey {
        case ranking
        case products
    }
    
    required init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        ranking = try container.decode(String.self, forKey: .ranking)
        
        let productsList = try container.decode([RankingProduct].self, forKey: .products)
        products.append(objectsIn: productsList)
        
        super.init()
    }
    
    override class func primaryKey() -> String?
    {
        return "ranking"
    }
    
    required init()
    {
        super.init()
    }
}
