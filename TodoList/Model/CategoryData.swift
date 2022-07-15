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
    
    var items : [Category]?
    
    
    //fetching category list
    mutating func loadItemData(moc:NSManagedObjectContext?){
        
        var fetchReq = NSFetchRequest<Category>(entityName: "Category")
        
        do{
            items = (try moc?.fetch(fetchReq))!
        }catch{
            print("Error in fetching category")
        }
        
    }
    
    func saveItemData(moc:NSManagedObjectContext?,item:String){
        var obj = NSEntityDescription.insertNewObject(forEntityName: "Category", into: moc!) as! Category
        obj.item = item
        
        //save
        do{
            try moc?.save()
            print("Data saved")
        }catch{
            print("error in saving data")
        }
        
    }
    
    
    
}
