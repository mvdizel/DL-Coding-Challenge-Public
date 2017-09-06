//
//  NextDayWeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Vasilii Muravev on 9/6/17.
//  Copyright © 2017 Vasilii Muravev. All rights reserved.
//

import UIKit

final class NextDayWeatherTableViewCell: BaseTableViewCell {
  
  // MARK: - @IBOutlets
  @IBOutlet private weak var dayNameLabel: UILabel!
  @IBOutlet private weak var temperatureLabel: UILabel!
  
  
  // MARK: - Public Methods
  func configure(_ temperature: Int, _ dayName: String) {
    temperatureLabel.text = "\(temperature)°"
    dayNameLabel.text = dayName
  }
}
