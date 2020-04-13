//
//  UITextField+Extensions.swift
//  PostsApp
//
//  Created by Pavan Kumar Valluru on 13.04.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import UIKit

extension UITextField {

    func setBottomBorder(with color: UIColor = .gray) {
    self.borderStyle = .none
    self.layer.backgroundColor = UIColor.white.cgColor
    self.layer.masksToBounds = false
    self.layer.shadowColor = color.cgColor
    self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
    self.layer.shadowOpacity = 1.0
    self.layer.shadowRadius = 0.0
  }
}
