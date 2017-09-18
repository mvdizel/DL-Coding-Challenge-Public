//
//  Date+Extension.swift
//  WeatherApp
//
//  Created by Vasilii Muravev on 9/18/17.
//  Copyright © 2017 Vasilii Muravev. All rights reserved.
//

import Foundation

extension Date {
  func dayName() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    return dateFormatter.string(from: self)
  }
}
