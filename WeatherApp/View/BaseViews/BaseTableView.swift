//
//  BaseTableView.swift
//  WeatherApp
//
//  Created by Vasilii Muravev on 9/6/17.
//  Copyright © 2017 Vasilii Muravev. All rights reserved.
//

import UIKit

@IBDesignable class BaseTableView: UITableView {
  
  // MARK: - @IBInspectables
  @IBInspectable var isClearBackground: Bool = false { didSet {
    setup()
  }}
  
  
  // MARK: - Private Attributes
  private var cachedBackgroundView: UIView?
  
  
  // MARK: - Private Methods
  private func setup() {
    if cachedBackgroundView == nil {
      cachedBackgroundView = backgroundView
    }
    clearBackground()
  }
  
  private func clearBackground() {
    guard isClearBackground else {
      backgroundView = cachedBackgroundView
      isOpaque = true
      return
    }
    backgroundView = nil
    isOpaque = false
    backgroundColor = .clear
  }
}
