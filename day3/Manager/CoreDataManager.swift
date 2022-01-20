//
//  CoreDataManager.swift
//  day3
//
//  Created by AMPA on 17/01/22.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    
    init(){
        persistentContainer = NSPersistentContainer(name: "day3CoreDataModel")
        persistentContainer.loadPersistentStores{(description, error) in
            if let error = error{
                fatalError("Core Data Store failed \(error.localizedDescription)")
            }
        }
    }
    
    func getAllPerson()->[Person]{

        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()

        do{
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch{
            return []
        }

    }
    
    func savePerson(name : String, address : String, dob : Date, phone : String, gender : String, latitude : Double, longitude : Double){
        
        let person = Person(context: persistentContainer.viewContext)
        person.name = name
        person.address = address
        person.phone = phone
        person.gender = gender
        person.dob = dob
        person.latitude = latitude
        person.longitude = longitude

        do{
            try persistentContainer.viewContext.save()
        }
        catch{
            print("failed to save person \(error)")
        }
    }
    
}

