//
//  NetworkManagerTests.swift
//  WeatherApp
//
//  Created by Vasilii Muravev on 9/6/17.
//  Copyright © 2017 Vasilii Muravev. All rights reserved.
//

import XCTest
import CoreLocation
@testable import WeatherApp

class NetworkManagerTests: XCTestCase {
  
  // MARK: - Private Test Attributes
  private let location = CLLocationCoordinate2D(latitude: 26.3, longitude: -80.1)
  private let networkManager = NetworkManager.shared
  
  
  // MARK: - Tests
  func testSingleton() {
    XCTAssertNotNil(networkManager)
  }
  
  func testGetCurrentWeather() {
    let getExpectation = expectation(description: "Fetching Current Weather Expectation")
    networkManager.getCurrentWeather(for: location, success: { weather in
      XCTAssertNotNil(weather)
      getExpectation.fulfill()
    }, failure: { error in
      XCTFail("Error fetching weather!")
      getExpectation.fulfill()
    })
    waitForExpectations(timeout: 10, handler: nil)
  }
  
  func testGetForecastWeather() {
    let getExpectation = expectation(description: "Fetching Forecast Weather Expectation")
    networkManager.getForecastWeather(for: location, success: { weather in
      XCTAssertNotNil(weather)
      XCTAssertEqual(weather.count, 4) // 3 days forecast and current weather
      getExpectation.fulfill()
    }, failure: { error in
      XCTFail("Error fetching weather!")
      getExpectation.fulfill()
    })
    waitForExpectations(timeout: 10, handler: nil)
  }
}
