//
//  ToDoListTests.swift
//  ToDoListTests
//
//  Created by Hoang Trong Kien on 5/1/20.
//  Copyright © 2020 Hoang Trong Kien. All rights reserved.
//

import XCTest
import CoreData
@testable import ToDo_List

class ToDoListTests: XCTestCase {
  
  var taskDataManager: TaskDataManager!
  
  override func setUpWithError() throws {
    super.setUp()
    taskDataManager = TaskDataManager.sharedManager
  }
  
  override func tearDownWithError() throws {
    super.tearDown()
  }
  
  func testPerformanceExample() throws {
    // This is an example of a performance test case.
    measure {
      // Put the code you want to measure the time of here.
    }
  }
  
  // MARK: - Our test case
  func test_init_taskDataManager() {
    let instance = TaskDataManager.sharedManager
    XCTAssertNotNil(instance)
  }
  
  func test_coreDataStackInitialization() {
    let coreDataStack = TaskDataManager.sharedManager.persistentContainer
    XCTAssertNotNil(coreDataStack)
  }
  
  func test_create_task() {
    let name1 = "Task 1"
    let detail1 = "Detail 1"
    let isDone1 = false
    let date1 = myDate()
    
    let task1 = taskDataManager.insertTask(name: name1, detail: detail1, isDone: isDone1, date: date1)
    XCTAssertNotNil(task1)
    
    let name2 = "Task 2"
    let detail2 = "Detail 2"
    let isDone2 = false
    let date2 = myDate()
    
    let task2 = taskDataManager.insertTask(name: name2, detail: detail2, isDone: isDone2, date: date2)
    XCTAssertNotNil(task2)
  }
  
  func myDate() -> Date {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd HH:mm"
    return formatter.date(from: "2020/05/02 09:30")!
  }
  
  func test_fetch_all_task() {
    let tasks = taskDataManager.fetchAllTasks()
    print("begin")
    for task in tasks! {
      print(task.name)
      print(task.detail)
    }
    print("end")
    //XCTAssertEqual(tasks?.count, 3)
  }
  
  func test_remove_task() {
    let tasks = taskDataManager.fetchAllTasks()
    let numberOfTasks = tasks?.count
    
    let task = tasks![0]
    taskDataManager.delete(task: task)
    
    XCTAssertEqual(taskDataManager.fetchAllTasks()?.count, numberOfTasks! - 1)
  }
  
  func test_update_task() {
    let tasks = taskDataManager.fetchAllTasks()
    //update first task
    let firstTask = tasks![0]
    let newName = "New name"
    let newDetail = "New detail"
    let newDate = myDate()
    let isDone = false
    
    TaskDataManager.sharedManager.update(name: newName, detail: newDetail, isDone: isDone, date: newDate, task: firstTask)
    
    let updatedTasks = taskDataManager.fetchAllTasks()
    let firstUpdatedTask = updatedTasks![0]
    
    XCTAssertEqual(firstUpdatedTask.name!, newName)
    XCTAssertEqual(firstUpdatedTask.detail!, newDetail)
    XCTAssertEqual(firstUpdatedTask.date!, newDate)
    XCTAssertEqual(firstUpdatedTask.isDone, isDone)
  }
  
  func test_flushData() {
    taskDataManager.flushData()
    XCTAssertEqual(taskDataManager.fetchAllTasks()?.count, 0)
  }
}
