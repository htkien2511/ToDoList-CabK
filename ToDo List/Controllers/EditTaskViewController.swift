//
//  DetailTaskViewController.swift
//  ToDo List
//
//  Created by Hoang Trong Kien on 5/3/20.
//  Copyright © 2020 Hoang Trong Kien. All rights reserved.
//

import UIKit

class EditTaskViewController: UIViewController {
  
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var nameTextView: UITextView!
  @IBOutlet weak var detailTextView: UITextView!
  @IBOutlet weak var dateTextView: UITextView!
  @IBOutlet weak var cancelButton: UIButton!
  @IBOutlet weak var saveButton: UIButton!
  
  var currentTask: Task?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupData()
    setupElements()
    
    let viewIsTap = UITapGestureRecognizer(target: self, action: #selector(viewIsTapped))
    view.addGestureRecognizer(viewIsTap)
  }
  
  @objc func viewIsTapped() {
    view.endEditing(true)
  }
  
  func setupData() {
    nameTextView.text = currentTask!.name
    detailTextView.text = currentTask!.detail
    
    // display date with style "MM,dd,yy, hh:mm a"
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    let date = formatter.string(from: currentTask!.date!)
    dateTextView.text = "\(date)"
  }
  
  func setupElements() {
    containerView.corner()
    containerView.shadow()
    nameTextView.corner(radius: 5)
    nameTextView.shadow()
    detailTextView.corner(radius: 5)
    detailTextView.shadow()
    dateTextView.corner(radius: 5)
    dateTextView.shadow()
    cancelButton.corner()
    cancelButton.shadow()
    saveButton.corner()
    saveButton.shadow()
  }
  
  @IBAction func cancelButtonTapped(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  @IBAction func saveButtonTapped(_ sender: Any) {
    let newName = nameTextView.text!
    let newDetail = detailTextView.text!

    // convert string of date To Date
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    let date = formatter.date(from: dateTextView.text)
    guard let safeDate = date else {
      showAlert(message: "Wrong date")
      return
    }
    let isDone = currentTask!.isDone
    
    let successUpdate = TaskDataManager.sharedManager.update(name: newName, detail: newDetail, isDone: isDone, date: safeDate, task: currentTask!)
    if successUpdate {
      dismiss(animated: true, completion: nil)
    } else {
      // show alert
    }
  }
  
  func showAlert(message: String) {
    let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
}
