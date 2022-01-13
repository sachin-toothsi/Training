//
//  CoreDataManager.swift
//  day2
//
//  Created by AMPA on 13/01/22.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    
    init(){
        persistentContainer = NSPersistentContainer(name: "day2CoreDataModel")
        persistentContainer.loadPersistentStores{(description, error) in
            if let error = error{
                fatalError("Core Data Store failed \(error.localizedDescription)")
            }
        }
    }
    
//    func getAllPerson()->[Person]{
//        
//        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
//        
//        do{
//            return try persistentContainer.viewContext.fetch(fetchRequest)
//        } catch{
//            return []
//        }
//        
//    }
    
    func savePerson(name : String, address : String, dob : Date, phone : String, gender : String){
        
        let person = Person(context: persistentContainer.viewContext)
        person.name = name
        person.address = address
        person.phone = phone
        person.gender = gender
        person.dob = dob
        
        do{
            try persistentContainer.viewContext.save()
        }
        catch{
            print("failed to save person \(error)")
        }
    }
    
}
