//
//  TemperatureTableViewCell.swift
//  WeatherApp
//
//  Created by Vasilii Muravev on 9/6/17.
//  Copyright © 2017 Vasilii Muravev. All rights reserved.
//

import UIKit

final class TemperatureTableViewCell: BaseTableViewCell {
  
  // MARK: - @IBOutlets
  @IBOutlet private weak var temperatureLabel: UILabel!
  
  
  // MARK: - Public Methods
  func configure(_ temperature: Int) {
    temperatureLabel.text = "\(temperature)°"
  }
}
