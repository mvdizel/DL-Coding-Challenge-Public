//
//  BaseView.swift
//  WeatherApp
//
//  Created by Vasilii Muravev on 9/6/17.
//  Copyright © 2017 Vasilii Muravev. All rights reserved.
//

import UIKit

class BaseView: UIView {
  func loadXibView(with xibFrame: CGRect) -> UIView {
    let className = String(describing: type(of: self))
    let bundle = Bundle(for: type(of: self))
    let nib = UINib(nibName: className, bundle: bundle)
    guard let xibView = nib.instantiate(withOwner: self, options: nil)[0] as? UIView else {
      return UIView()
    }
    xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    xibView.frame = xibFrame
    return xibView
  }
}
