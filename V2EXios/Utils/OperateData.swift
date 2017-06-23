//
//  PublicFucn.swift
//  V2EXios
//
//  Created by 王浩 on 2017/6/20.
//  Copyright © 2017年 haowang. All rights reserved.
//

import Foundation
import  MagicalRecord
import CoreData
var operateData = OperateData()


/**
 * CoreData 增删改查封装
 */
class OperateData {
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: URL = {
        
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        
        let modelURL = Bundle.main.url(forResource: "StoryLineApp", withExtension: "momd")!
        print(modelURL)
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("SingleViewCoreData.sqlite")
        
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            //            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    
    
    
    func getObjects<T:BaseModel>() -> [T]{
        
        var objs : [T] = T.mr_findAll()! as? [T] ?? []
        
        if objs.count > 0 {
            objs = objs.sorted{$0.id < $1.id}
        }
        return objs
        
    }

    
    func deleteObj(_ T:BaseModel){
        T.mr_deleteEntity()
    }

    func newObj<T : BaseModel>() -> T{
        let obj = T.mr_createEntity()
        return obj!
        
    }
    

    func check<T : BaseModel>(_ attribute : String, pre : Any) -> [T]{
        var objs : [T] = T.mr_find(byAttribute: attribute, withValue: pre) as? [T] ?? []
        
        if objs.count > 0 {
            objs = objs.sorted{$0.id < $1.id}
        }
        return objs
    }
    
    func save() {
        NSManagedObjectContext.mr_default().mr_saveToPersistentStoreAndWait()
    }
    func removeEntity(T : [BaseModel]) {
        for sub in T {
            sub.mr_deleteEntity()
        }
    }
}
