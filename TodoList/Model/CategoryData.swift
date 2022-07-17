//
//  ItemData.swift
//  TodoList
//
//  Created by Ajin on 14/07/22.
//

import Foundation
import UIKit
import CoreData

struct CategoryData{
    
    var items : [Category] = []
    
    
    //fetching category list
    mutating func loadItemData(moc:NSManagedObjectContext?, predicate:NSPredicate?=nil){
        
        var fetchReq = NSFetchRequest<Category>(entityName: "Category")
        if let finalPredicate = predicate{
            fetchReq.predicate = finalPredicate
        }
        
        do{
            items = (try moc?.fetch(fetchReq))!
            deleteEmptyTitile()
            saveCategory(moc: moc!)
        }catch{
            print("Error in fetching category")
        }
        
    }
    
    func saveItemData(moc:NSManagedObjectContext?,item:String){
        
        if item.count == 0{
            print("Unwanted Save")
        }else{
            var obj = NSEntityDescription.insertNewObject(forEntityName: "Category", into: moc!) as! Category
            obj.item = item
            
            //save
            saveCategory(moc: moc!)
        }
        
        
    }
    
    func saveCategory(moc:NSManagedObjectContext?){
        do{
            try moc?.save()
            print("Data saved")
        }catch{
            print("error in saving data")
        }
    }
    
    mutating func deleteEmptyTitile(){
        var itemArray : [Category] = []
        for item in items{
            if item.item != nil{
                itemArray.append(item)
            }
        }
        items = itemArray
        
    }
}
