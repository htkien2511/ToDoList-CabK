//
//  ToDoListCell.swift
//  ToDo List
//
//  Created by Hoang Trong Kien on 4/28/20.
//  Copyright © 2020 Hoang Trong Kien. All rights reserved.
//

import UIKit

protocol ChangeButton {
  func changeButton(isDone: Bool, indexP: Int)
}

class ToDoListCell: UITableViewCell {
  
  @IBOutlet weak var containerCell: UIView!
  @IBOutlet weak var taskLabel: UILabel!
  @IBOutlet weak var checkedButton: UIButton!
  
  var delegate: ChangeButton?
  var indexP: Int?
  var tasks: [Task]?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    setUpCell()
  }
  
  func setUpCell() {
    containerCell.layer.cornerRadius = CGFloat(10.0)
    containerCell.layer.shadowOpacity = 0.5
    containerCell.layer.shadowColor = UIColor.black.cgColor
    containerCell.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
  }
  
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  
  
  @IBAction func checkedTapped(_ sender: UIButton) {
    if tasks![indexP!].isDone {
      delegate?.changeButton(isDone: false, indexP: indexP!)
    } else {
      delegate?.changeButton(isDone: true, indexP: indexP!)
    }
  }
}
