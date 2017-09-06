//
//  WeatherInfoViewModel.swift
//  WeatherApp
//
//  Created by Vasilii Muravev on 9/6/17.
//  Copyright © 2017 Vasilii Muravev. All rights reserved.
//

import Foundation

enum WeatherSection: Int {
  case current = 0
  case forecast
  
  static func count() -> Int {
    return 2
  }
  
  func rows() -> Int {
    switch self {
    case .current:
      return 1
    case .forecast:
      return 7 // next 7 days
    }
  }
  
  func cellIdentifier() -> String {
    switch self {
    case .current:
      return TemperatureTableViewCell.identifier()
    case .forecast:
      return NextDayWeatherTableViewCell.identifier()
    }
  }
}

protocol WeatherInfoProtocol {
  // @TODO: Add dynamic binders for refreshing table view.
  
  // MARK: - Public Methods
  func numberOfSections() -> Int
  func numberOfRows(in section: Int) -> Int
  func cellIdentifier(for section: Int) -> String?
  func temperature(for indexPath: IndexPath) -> Int
  func location() -> String
  func dayName(for indexPath: IndexPath) -> String
}

final class WeatherInfoViewModel: WeatherInfoProtocol {
  
  // MARK: - WeatherInfoProtocol Methods
  // @TODO: Implement methods after writing tests.
  func numberOfRows(in section: Int) -> Int {
    guard let section = WeatherSection(rawValue: section) else {
      return 0
    }
    return section.rows()
  }
  
  func numberOfSections() -> Int {
    return WeatherSection.count()
  }
  
  func cellIdentifier(for section: Int) -> String? {
    guard let section = WeatherSection(rawValue: section) else {
      return nil
    }
    return section.cellIdentifier()
  }
  
  func temperature(for indexPath: IndexPath) -> Int {
    return 77
  }
  
  func location() -> String {
    return "Boca Raton, FL"
  }
  
  func dayName(for indexPath: IndexPath) -> String {
    return "Monday"
  }
}
