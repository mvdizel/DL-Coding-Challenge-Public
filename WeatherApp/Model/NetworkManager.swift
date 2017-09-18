//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Vasilii Muravev on 9/6/17.
//  Copyright © 2017 Vasilii Muravev. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation

private let baseUrl = "http://api.wunderground.com/api"
private let appKey = "933e02c055e7ee69" // @TODO: Oh, no, secret key on GitHub!....

final class NetworkManager {
  
  private enum Endpoint: String {
    case current = "conditions"
    case hourly = "hourly"
    case forecast = "forecast" // 3 days for Demo enough
    case geolookup = "geolookup"
    
    /// Returns full url string with app key.
    func fullUrl() -> String {
      return baseUrl + "/" + appKey + "/" + self.rawValue
    }
    
    /// Returns full url string with app key for selected location.
    ///
    /// - Parameter location: A `CLLocationCoordinate2D`, representing selected location.
    /// - Returns: A `String` with attached location query.
    func fullUrl(for location: CLLocationCoordinate2D) -> String {
      let latitude = String(format:"%f", location.latitude)
      let longitude = String(format:"%f", location.longitude)
      return fullUrl() + "/q/" + latitude + "," + longitude + ".json"
    }
    
    /// Returns full url string with app key for selected city.
    ///
    /// - Parameter city: A `City`, representing selected city.
    /// - Returns: A `String` with attached city query.
    func fullUrl(for city: City) -> String {
      let city = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
      return fullUrl() + "/q/" + city + ".json"
    }
  }
  
  
  // MARK: - Singleton
  static let shared = NetworkManager()
  
  
  // MARK: - Initializers
  private init() {}
  
  
  // MARK: - Public Instance Methods
  func getCurrentWeather(for location: CLLocationCoordinate2D, success: @escaping (WeatherForecast) -> Void, failure: @escaping (Error?) -> Void) {
    getCity(for: location, success: { city in
      let url = Endpoint.current.fullUrl(for: city)
      Alamofire.request(url).validate().responseJSON { response in
        guard let result = response.value as? [String: Any],
              let json = result["current_observation"] as? [String: Any],
              let currentWeather = WeatherForecast(parsingCurrent: json) else {
          // @TODO: Create custom error and return it in failure with description.
          failure(response.error)
          return
        }
        success(currentWeather)
      }
    }, failure: { error in
      failure(error)
    })
  }
  
  func getForecastWeather(for location: CLLocationCoordinate2D, success: @escaping ([WeatherForecast]) -> Void, failure: @escaping (Error?) -> Void) {
    getCity(for: location, success: { city in
      let url = Endpoint.forecast.fullUrl(for: city)
      Alamofire.request(url).validate().responseJSON { response in
        guard let result = response.value as? [String: Any],
              let forecast = result["forecast"] as? [String: Any],
              let simpleforecast = forecast["simpleforecast"] as? [String: Any],
              let forecasts = simpleforecast["forecastday"] as? [[String: Any]] else {
          // @TODO: Create custom error and return it in failure with description.
          failure(response.error)
          return
        }
        let weather = forecasts.flatMap({ WeatherForecast(parsingForecast: $0, city) })
        success(weather)
      }
    }, failure: { error in
      failure(error)
    })
  }

  
  // MARK: - Private Instance Methods
  private func getCity(for location: CLLocationCoordinate2D, success: @escaping (City) -> Void, failure: @escaping (Error?) -> Void) {
    let url = Endpoint.geolookup.fullUrl(for: location)
    Alamofire.request(url).validate().responseJSON { response in
      guard let result = response.value as? [String: Any],
            let forecast = result["location"] as? [String: Any],
            let city = forecast["city"] as? City else {
        // @TODO: Create custom error and return it in failure with description.
        failure(response.error)
        return
      }
      success(city)
    }
  }
}
