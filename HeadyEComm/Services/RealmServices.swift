//
//  RealmServices.swift
//  HeadyEComm
//
//  Created by Keval Shah on 4/6/20.
//  Copyright © 2020 Keval Shah. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService {
    
    private init() {
        
    }
    
    static let shared = RealmService()
    var realm = try! Realm()
    
    func post(_ error: Error) {
        NotificationCenter.default.post(name: NSNotification.Name("RealmError"), object: error)
    }
    
    func trackRealmErrors(in vc: ViewController, completion: @escaping (Error?) -> Void) {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("RealmError"),
                                               object: nil,
                                               queue: nil) { notification in
                                                completion(notification.object as? Error)
        }
    }
    
    func stopTrackErrors(in vc: ViewController) {
        NotificationCenter.default.removeObserver(vc, name: NSNotification.Name("RealmError"), object: nil) 
    }
}
