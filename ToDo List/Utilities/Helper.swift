//
//  Helper.swift
//  ToDo List
//
//  Created by Hoang Trong Kien on 4/28/20.
//  Copyright © 2020 Hoang Trong Kien. All rights reserved.
//

import UIKit

extension UIView {
  func corner(radius: CGFloat = 15.0) {
    self.layer.cornerRadius = radius
    self.layer.masksToBounds = true
  }
  
  func shadow(color: CGColor = UIColor.black.cgColor, opacity: Float = 0.5, radius: CGFloat = 5.0) {
    self.layer.shadowOpacity = opacity
    self.layer.shadowColor = color
    self.layer.shadowRadius = radius
    self.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
  }
}
