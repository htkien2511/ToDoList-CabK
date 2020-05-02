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
  
  func fetchAllTasks() -> [Task]? {
    let managedContext = TaskDataManager.sharedManager.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Task")
    do {
      let tasks = try managedContext.fetch(fetchRequest)
      return tasks as? [Task]
    } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
      return nil
    }
  }
  
  func delete(task: Task) {
    let managedContext = TaskDataManager.sharedManager.persistentContainer.viewContext
    do {
      managedContext.delete(task)
      try managedContext.save()
    } catch let error as NSError {
      print("Could not delete. \(error), \(error.userInfo)")
    }
  }
  
  func update(name: String, detail: String, isDone: Bool, date: Date, task: Task) {
    let managedContext = TaskDataManager.sharedManager.persistentContainer.viewContext
    task.setValue(name, forKey: "name")
    task.setValue(detail, forKey: "detail")
    task.setValue(isDone, forKey: "isDone")
    task.setValue(date, forKey: "date")
    
    do {
      try managedContext.save()
    } catch let error as NSError {
      print("Could not update. \(error), \(error.userInfo)")
    }
  }
  
  func flushData() {
    let managedContext = TaskDataManager.sharedManager.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Task")
    do {
      let tasks = try managedContext.fetch(fetchRequest)
      for task in tasks {
        managedContext.delete(task)
      }
    } catch let error as NSError {
      print("Could not fetch data to flush. \(error), \(error.userInfo)")
    }
    do {
      try managedContext.save()
    } catch let error as NSError {
      print("Could not flush data. \(error), \(error.userInfo)")
    }
  }
}

