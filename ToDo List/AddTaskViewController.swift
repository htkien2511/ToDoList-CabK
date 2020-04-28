//
//  AddTaskViewController.swift
//  ToDo List
//
//  Created by Hoang Trong Kien on 4/28/20.
//  Copyright © 2020 Hoang Trong Kien. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {
  
  @IBOutlet weak var containerAddTaskView: UIView!
  @IBOutlet weak var nameTextView: UITextView!
  @IBOutlet weak var descriptionTextView: UITextView!
  @IBOutlet weak var addTaskButton: UIButton!
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpElements()
  }
  
  func setUpElements() {
    containerAddTaskView.corner()
    containerAddTaskView.shadow()
    nameTextView.corner(radius: 5)
    nameTextView.shadow()
    descriptionTextView.corner(radius: 5)
    descriptionTextView.shadow()
    addTaskButton.corner()
    addTaskButton.shadow()
  }
  @IBAction func addTaskTapped(_ sender: UIButton) {
  }
}
