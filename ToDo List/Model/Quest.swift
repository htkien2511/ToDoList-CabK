//
//  Task.swift
//  ToDo List
//
//  Created by Hoang Trong Kien on 4/29/20.
//  Copyright © 2020 Hoang Trong Kien. All rights reserved.
//

import UIKit

struct Quest {
  var name: String
  var description: String
  var isDone: Bool = false
  
  init(name: String, description: String) {
    self.name = name
    self.description = description
  }
}
