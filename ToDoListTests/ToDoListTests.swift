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
  
  
}
