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
    tableView.delegate = self
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
    cell.delegate = self
    return cell
  }
  
}

extension ToDoListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let task = tasks[indexPath.row]
    performSegue(withIdentifier: "detailTask", sender: task)
  }
  
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let delete = UIContextualAction(style: .normal, title: "Delete") { (action, view, nil) in
      let task = self.tasks[indexPath.row] as! Task
      TaskDataManager.sharedManager.delete(task: task)
      self.tasks.remove(at: indexPath.row)
      tableView.reloadData()
    }
    delete.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.5960784314, blue: 0.8588235294, alpha: 1)
    delete.image = #imageLiteral(resourceName: "trash")
    let config = UISwipeActionsConfiguration(actions: [delete])
    config.performsFirstActionWithFullSwipe = false
    return config
  }
}

extension ToDoListViewController {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "detailTask" {
      guard let destinationVC = segue.destination as? EditTaskViewController else { return }
      guard let task = sender as? Task else { return }
      destinationVC.currentTask = task
    }
  }
}

extension ToDoListViewController: ToogleButton {
  func toogleButton() {
    tableView.reloadData()
  }
}
