//
//  WeatherInfoViewModelTests.swift
//  WeatherApp
//
//  Created by Vasilii Muravev on 9/6/17.
//  Copyright © 2017 Vasilii Muravev. All rights reserved.
//

import XCTest
@testable import WeatherApp

class WeatherInfoViewModelTests: XCTestCase {
  
  // MARK: - Private Test Attributes
  private let viewModel = WeatherInfoViewModel()
  
  
  // MARK: - Tests
  func testInitializer() {
    XCTAssertNotNil(viewModel)
  }
  
  func testGetCurrentWeather() {
    XCTAssertEqual(viewModel.numberOfRows(in: WeatherSection.current.rawValue), 0)
    XCTAssertEqual(viewModel.numberOfRows(in: WeatherSection.forecast.rawValue), 0)
    XCTAssertEqual(viewModel.numberOfSections(), WeatherSection.count())
    XCTAssertEqual(viewModel.location(), "...")
    let testIndexPath = IndexPath(row: 0, section: WeatherSection.current.rawValue)
    XCTAssertEqual(viewModel.temperature(for: testIndexPath), 0)
    // @TODO: And so on for all other functions...
    let refreshCurrentExpectation = expectation(description: "Refresh Current Expectation")
    let refreshForecastExpectation = expectation(description: "Refresh Forecast Expectation")
    viewModel.refreshSection.bind(with: self) { (section) in
      switch section {
      case .current:
        // @TODO: Implemet tests for refreshed section.
        refreshCurrentExpectation.fulfill()
      case .forecast:
        // @TODO: Implemet tests for refreshed section.
        refreshForecastExpectation.fulfill()
      }
    }
    viewModel.refresh()
    waitForExpectations(timeout: 10, handler: nil)
  }
}
