//
//  Operations.swift
//  HeadyEComm
//
//  Created by Keval Shah on 4/6/20.
//  Copyright © 2020 Keval Shah. All rights reserved.
//

import Foundation
import RealmSwift

class Operations {
    
    func storeModels()
    {
        guard let url = URL(string: "https://stark-spire-93433.herokuapp.com/json") else {
            return
        }
        
        do {
            URLSession.shared.dataTask(with: url) { data, response, error in
               if let data = data {
                   do {
                      let inventory = try JSONDecoder().decode(Inventory.self, from: data)
                      let realm = try Realm()
                      print(realm.configuration.fileURL?.absoluteString ?? "")
                      
                      try realm.write {
                        realm.add(inventory.categories)
                        realm.add(inventory.rankings, update: .modified)
                      }
                   } catch let error {
                      print(error)
                   }
                }
            }.resume()
        }
    }
}
