//
//  ItemData.swift
//  TodoList
//
//  Created by Ajin on 15/07/22.
//

import Foundation
import CoreData

struct ItemData{
    var items : [Item] = []
    
    
    //fetching category list
    mutating func loadItemData(moc:NSManagedObjectContext?, predicate:NSPredicate?=nil){
        
        var fetchReq = NSFetchRequest<Item>(entityName: "Item")
        if let finalPredicate = predicate{
            fetchReq.predicate = finalPredicate
        }
        
        do{
            items = (try moc?.fetch(fetchReq))!
            print(items.count)
        }catch{
            print("Error in fetching category")
        }
        
    }
    
    func saveItemData(moc:NSManagedObjectContext?, name:String, priroty:String, done:Bool,  parent:Category){
        var obj = NSEntityDescription.insertNewObject(forEntityName: "Item", into: moc!) as! Item
        obj.done = false
        obj.name = name
        obj.priority = priroty
        obj.parentRelationship = parent
        
        doSave(moc: moc)
        
    }
    
    func doSave(moc:NSManagedObjectContext?){
        //save
        do{
            try moc?.save()
            print("Data saved")
        }catch{
            print("error in saving data")
        }
    }
    
}
