//
//  AddTaskViewController.swift
//  ToDo List
//
//  Created by Hoang Trong Kien on 4/28/20.
//  Copyright © 2020 Hoang Trong Kien. All rights reserved.
//

import UIKit
import CoreData

class AddTaskViewController: UIViewController {
  
  @IBOutlet weak var containerAddTaskView: UIView!
  @IBOutlet weak var nameTextView: UITextView!
  @IBOutlet weak var descriptionTextView: UITextView!
  @IBOutlet weak var datePicker: UIDatePicker!
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
    guard let name = nameTextView.text,
      let detail = descriptionTextView.text else { return }
    // test date => this is incomplete
    let date = datePicker.date
    let task = TaskDataManager.sharedManager.insertTask(name: name, detail: detail, isDone: false, date: date)
    if task != nil {
      dismiss(animated: true, completion: nil)
    }
  } 
  
}
