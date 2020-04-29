//
//  TaskData.swift
//  ToDo List
//
//  Created by Hoang Trong Kien on 4/29/20.
//  Copyright © 2020 Hoang Trong Kien. All rights reserved.
//

import UIKit
import CoreData

class TaskData {
  var tasks: [NSManagedObject] = []
  
  func fetchData() {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    
    let managedContext = appDelegate.persistentContainer.viewContext
    
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Task")
    
    do {
        tasks = try managedContext.fetch(fetchRequest)
    } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
    }
  }
  
  func saveData(name: String, description: String) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    
    let managedContext = appDelegate.persistentContainer.viewContext
    
    let entity = NSEntityDescription.entity(forEntityName: "Task", in: managedContext)!
    let task = NSManagedObject(entity: entity, insertInto: managedContext)
    task.setValue(name, forKeyPath: "name")
    task.setValue(description, forKeyPath: "detail")
    
    do {
        try managedContext.save()
        tasks.append(task)
    } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
    }
  }
}

