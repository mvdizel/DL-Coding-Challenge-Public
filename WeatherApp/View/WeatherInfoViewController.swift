//
//  ViewController.swift
//  WeatherApp
//
//  Created by Vasilii Muravev on 9/6/17.
//  Copyright © 2017 Vasilii Muravev. All rights reserved.
//

import UIKit

final class WeatherInfoViewController: UIViewController {
  
  // MARK: - Private Attributes
  @IBOutlet fileprivate weak var tableView: BaseTableView!
  
  
  // MARK: - Private Attributes
  var viewModel: WeatherInfoProtocol = WeatherInfoViewModel()
  
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
}


// MARK: - UITableViewDataSource
extension WeatherInfoViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return viewModel.numberOfSections()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfRows(in: section)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let section = WeatherSection(rawValue: indexPath.section) else {
      return UITableViewCell()
    }
    switch section {
    case .current:
      return tableView.dequeueReusableCell(withIdentifier: TemperatureTableViewCell.identifier(), for: indexPath) as! TemperatureTableViewCell
    case .forecast:
      return tableView.dequeueReusableCell(withIdentifier: NextDayWeatherTableViewCell.identifier(), for: indexPath) as! NextDayWeatherTableViewCell
    }
  }
}


// MARK: - UITableViewDelegate
extension WeatherInfoViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard let section = WeatherSection(rawValue: section) else {
      return nil
    }
    switch section {
    case .current:
      return CurrentWeatherHeader()
    case .forecast:
      return ForecastWeatherHeader()
    }
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    guard let section = WeatherSection(rawValue: indexPath.section) else {
      return
    }
    switch section {
    case .current:
      guard let cell = cell as? TemperatureTableViewCell else {
        return
      }
      cell.configure(viewModel.temperature(for: indexPath))
    case .forecast:
      guard let cell = cell as? NextDayWeatherTableViewCell else {
        return
      }
      cell.configure(
        viewModel.temperature(for: indexPath),
        viewModel.dayName(for: indexPath)
      )
    }
  }
  
  func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    guard let section = WeatherSection(rawValue: section) else {
      return
    }
    switch section {
    case .current:
      guard let view = view as? CurrentWeatherHeader else { return }
      view.configure(viewModel.location())
    case .forecast:
      return
    }
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    guard let section = WeatherSection(rawValue: section) else {
      return 0.001
    }
    switch section {
    case .current:
      return 44.0
    case .forecast:
      return 0.001
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    guard let section = WeatherSection(rawValue: indexPath.section) else {
      return 0.001
    }
    switch section {
    case .current:
      return 166.0
    case .forecast:
      return 44.0
    }
  }
}


// MARK: - Private Methods
private extension WeatherInfoViewController {
  func setup() {
    // @TODO: Fix headers for table view. Hide current temperature, when scroll up.
  }
}
