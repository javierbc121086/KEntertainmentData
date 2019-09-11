//
//  RPEDataManager.swift
//  RPEntertainmentData
//
//  Created by Javier Bolaños on 9/10/19.
//  Copyright © 2019 gipsyhub. All rights reserved.
//

import Foundation
import CoreData

public class RPEDataManager {
    public static let shared = RPEDataManager()
    
    let identifier: String  = "mx.com.gipsyhub.RPEntertainmentData"
    let model: String       = "RPECoreDataModel"
    
    @available(iOS 10.0, *)
    lazy var persistentContainer: NSPersistentContainer? = {
        
        let messageKitBundle = Bundle(identifier: self.identifier)
        let modelURL = messageKitBundle!.url(forResource: self.model, withExtension: "momd")!
        
        if let managedObjectModel =  NSManagedObjectModel(contentsOf: modelURL) {
            let container = NSPersistentContainer(name: self.model, managedObjectModel: managedObjectModel)
            container.loadPersistentStores { (storeDescription, error) in
                if let err = error {
                    fatalError("Loading of store failed:\(err)")
                }
            }
            
            return container
        }
        
        return nil
    }()
}
