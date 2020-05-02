//
//  ViewController.swift
//  ToDo List
//
//  Created by Hoang Trong Kien on 4/28/20.
//  Copyright © 2020 Hoang Trong Kien. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UIViewController {

  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var tableView: UITableView!
  
  var tasks: [NSManagedObject] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpElements()
    setUpCells()

    tableView.dataSource = self
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    fetchAllTasks()
    tableView.reloadData()
  }
  
  func fetchAllTasks() {
    if TaskDataManager.sharedManager.fetchAllTasks() != nil {
      tasks = TaskDataManager.sharedManager.fetchAllTasks()!
    }
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
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    return tasks.count
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let task = tasks[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListCell",
                                             for: indexPath) as! ToDoListCell
    cell.taskLabel.text = task.value(forKeyPath: "name") as? String
    cell.task = task as? Task
    if task.value(forKeyPath: "isDone") as! Bool {
      cell.checkedButton.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
    } else {
      cell.checkedButton.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
    }
    return cell
  }
  
}

extension ToDoListViewController: UITableViewDelegate {
  
}

extension ToDoListViewController {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "addTask" {
      guard let destinationVC = segue.destination as? AddTaskViewController else { return }
      
    }
  }
}
