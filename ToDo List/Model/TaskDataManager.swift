//
//  TaskData.swift
//  ToDo List
//
//  Created by Hoang Trong Kien on 4/29/20.
//  Copyright © 2020 Hoang Trong Kien. All rights reserved.
//

import UIKit
import CoreData

class TaskDataManager {
  
  static let sharedManager = TaskDataManager()
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "ToDo_List")
    container.loadPersistentStores { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
    return container
  }()
  var tasks: [NSManagedObject] = []
  
  func insertTask(name: String, detail: String, isDone: Bool, date: Date) -> Task? {
    let managedContext = TaskDataManager.sharedManager.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "Task", in: managedContext)!
    let task = NSManagedObject(entity: entity, insertInto: managedContext)
    
    task.setValue(name, forKeyPath: "name")
    task.setValue(detail, forKeyPath: "detail")
    task.setValue(isDone, forKeyPath: "isDone")
    task.setValue(date, forKeyPath: "date")
    
    do {
      try managedContext.save()
      return task as? Task
    } catch let error as NSError {
      print("Could not save. \(error), \(error.userInfo)")
      return nil
    }
  }
  
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

