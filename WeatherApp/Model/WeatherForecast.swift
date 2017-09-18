//
//  WeatherForecast.swift
//  WeatherApp
//
//  Created by Vasilii Muravev on 9/6/17.
//  Copyright © 2017 Vasilii Muravev. All rights reserved.
//

import Foundation

typealias City = String

final class WeatherForecast {
  
  // MARK: - Public Instance Attributes
  var city: City
  var temperature: Int // @TODO: Double will be better. For demo Int ok.
  var date: Date
  
  
  // MARK: - Initializers
  init?(parsingCurrent json: [String: Any]) {
    guard let location = json["display_location"] as? [String: Any],
          let city = location["full"] as? City,
          let temperature = json["temp_f"] as? Double else {
      return nil
    }
    self.city = city
    self.temperature = Int(temperature)
    self.date = Date()
  }
  
  init?(parsingForecast json: [String: Any], _ city: City) {
    guard let period = json["period"] as? Int,
          let high = (json["high"] as? [String: String])?["fahrenheit"],
          let low = (json["low"] as? [String: String])?["fahrenheit"],
          let highTemp = Int(high),
          let lowTemp = Int(low) else {
      return nil
    }
    self.city = city
    self.temperature = Int(Double(highTemp + lowTemp) / 2.0)
    date = Calendar.current.date(byAdding: .day, value: period - 1, to: Date())!
  }
}
