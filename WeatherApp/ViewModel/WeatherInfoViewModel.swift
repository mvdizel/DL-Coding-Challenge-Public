//
//  WeatherInfoViewModel.swift
//  WeatherApp
//
//  Created by Vasilii Muravev on 9/6/17.
//  Copyright © 2017 Vasilii Muravev. All rights reserved.
//

import Foundation
import CoreLocation

enum WeatherSection: Int {
  case current = 0
  case forecast
  
  static func count() -> Int {
    return 2
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
  
  // MARK: - Public Attributes
  var refreshSection: DynamicBinderInterface<WeatherSection> { get }
  // @TODO: Add binder for error messages.
  
  
  // MARK: - Public Methods
  func refresh()
  func numberOfSections() -> Int
  func numberOfRows(in section: Int) -> Int
  func cellIdentifier(for section: Int) -> String?
  func temperature(for indexPath: IndexPath) -> Int
  func location() -> String
  func dayName(for indexPath: IndexPath) -> String
}

final class WeatherInfoViewModel: WeatherInfoProtocol {
  
  // MARK: - WeatherInfoProtocol Attributes
  var refreshSection: DynamicBinderInterface<WeatherSection> {
    return refreshSectionBinder.interface
  }
  
  
  // MARK: - Private Instance Attributes
  private let refreshSectionBinder = DynamicBinder<WeatherSection>(.current)
  private var currentWeather: WeatherForecast?
  private var forecastWeather: [WeatherForecast] = []
  
  
  // MARK: - WeatherInfoProtocol Methods
  func refresh() {
    // @TODO: Create location manager and get current location.
    let location = CLLocationCoordinate2D(latitude: 26.3, longitude: -80.1)
    NetworkManager.shared.getCurrentWeather(for: location, success: { [weak self] weather in
      guard let strongSelf = self else { return }
      strongSelf.currentWeather = weather
      strongSelf.refreshSectionBinder.value = .current
    }, failure: { error in
      // @TODO: Refresh again if error.
      // @TODO: Hundle error.
    })
    NetworkManager.shared.getForecastWeather(for: location, success: { [weak self] weather in
      guard let strongSelf = self else { return }
      strongSelf.forecastWeather = weather
      strongSelf.refreshSectionBinder.value = .forecast
    }, failure: { error in
      // @TODO: Refresh again if error.
      // @TODO: Hundle error.
    })
  }
  
  func numberOfRows(in section: Int) -> Int {
    guard let section = WeatherSection(rawValue: section) else {
      return 0
    }
    switch section {
    case .current:
      return currentWeather == nil ? 0 : 1
    case .forecast:
      return max(0, forecastWeather.count - 1)
    }
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
    return weather(at: indexPath)?.temperature ?? 0
  }
  
  func location() -> String {
    return currentWeather?.city ?? "..."
  }
  
  func dayName(for indexPath: IndexPath) -> String {
    return weather(at: indexPath)?.date.dayName() ?? ""
  }
  
  
  // MARK: - Private Instance Methods
  func weather(at indexPath: IndexPath) -> WeatherForecast? {
    guard let section = WeatherSection(rawValue: indexPath.section) else {
      return nil
    }
    switch section {
    case .current:
      return currentWeather
    case .forecast:
      guard indexPath.row + 1 < forecastWeather.count else {
        return nil
      }
      return forecastWeather[indexPath.row + 1]
    }
  }
}
