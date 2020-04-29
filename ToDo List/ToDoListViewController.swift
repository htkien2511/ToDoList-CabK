//
//  ViewController.swift
//  ToDo List
//
//  Created by Hoang Trong Kien on 4/28/20.
//  Copyright © 2020 Hoang Trong Kien. All rights reserved.
//

import UIKit

class ToDoListViewController: UIViewController {

  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var tableView: UITableView!
  
  var tasks: [Task] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpElements()
    setUpCells()
    tasks.append(Task(name: "Buy new sweatshirt", description: "Description1"))
    tasks.append(Task(name: "Begin promotion phase", description: "Description2"))
    tasks.append(Task(name: "Read an article", description: "Description3"))
    tableView.dataSource = self
  }
  
  func setUpElements() {
    containerView.corner()
    containerView.shadow()
    
    tableView.tableFooterView = UIView()
  }
  
  func setUpCells() {
    let toDoListCell = UINib(nibName: "ToDoListCell", bundle: nil)
    tableView.register(toDoListCell, forCellReuseIdentifier: "ToDoListCell")
  }
  
  @IBAction func addTaskTapped(_ sender: UIButton) {
    self.performSegue(withIdentifier: "addTask", sender: nil)
  }
}

extension ToDoListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tasks.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListCell", for: indexPath) as! ToDoListCell
    cell.taskLabel.text = tasks[indexPath.row].name
    if tasks[indexPath.row].isDone {
        cell.checkedButton.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
    } else {
        cell.checkedButton.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
    }
    cell.delegate = self
    cell.indexP = indexPath.row
    cell.tasks = tasks
    return cell
  }
  
}

extension ToDoListViewController: UITableViewDelegate {
  
}

extension ToDoListViewController {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "addTask" {
      guard let destinationVC = segue.destination as? AddTaskViewController else { return }
      destinationVC.delegate = self
    }
  }
}

extension ToDoListViewController: AddTask, ChangeButton {
  func changeButton(isDone: Bool, indexP: Int) {
    tasks[indexP].isDone = isDone
    tableView.reloadData()
  }
  
  func addTask(task: String) {
    tasks.append(Task(name: task, description: "None"))
    tableView.reloadData()
  }
}
