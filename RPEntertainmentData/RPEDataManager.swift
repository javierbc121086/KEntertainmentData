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
    private let concurrentQueue = DispatchQueue(label: "concurrentQueue", attributes: .concurrent)
    public static let shared = RPEDataManager()
    
    private init() { }
    
    let identifier      = "mx.com.gipsyhub.RPEntertainmentData"
    let coreDataModel   = "RPECoreDataModel"
    
    @available(iOS 10.0, *)
    lazy var persistentContainer: NSPersistentContainer? = {
        self.concurrentQueue.sync {
            let messageKitBundle = Bundle(identifier: self.identifier)
            if let modelURL = messageKitBundle?.url(forResource: self.coreDataModel, withExtension: "momd") {
                if let managedObjectModel =  NSManagedObjectModel(contentsOf: modelURL) {
                    let container = NSPersistentContainer(name: self.coreDataModel, managedObjectModel: managedObjectModel)
                    
                    container.loadPersistentStores { (storeDescription, error) in
                        if let err = error {
                            fatalError("Loading of store failed:\(err)")
                        }
                    }
                    
                    return container
                }
            }
            
            return nil
        }
    }()
}
