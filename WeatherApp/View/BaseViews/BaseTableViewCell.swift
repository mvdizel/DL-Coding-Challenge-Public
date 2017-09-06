//
//  BaseTableViewCell.swift
//  WeatherApp
//
//  Created by Vasilii Muravev on 9/6/17.
//  Copyright © 2017 Vasilii Muravev. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
  
  // MARK: - Public Class Methods
  class func identifier() -> String {
    return String(describing: self)
  }
}
