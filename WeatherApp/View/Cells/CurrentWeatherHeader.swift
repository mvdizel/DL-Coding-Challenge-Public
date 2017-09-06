//
//  CurrentWeatherHeader.swift
//  WeatherApp
//
//  Created by Vasilii Muravev on 9/6/17.
//  Copyright © 2017 Vasilii Muravev. All rights reserved.
//

import UIKit

final class CurrentWeatherHeader: BaseView {
  
  // MARK: - @IBOutlets
  @IBOutlet private weak var locationLabel: UILabel!
  
  
  // MARK: - Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(loadXibView(with: bounds))
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    addSubview(loadXibView(with: bounds))
  }
  
  
  // MARK: - Public Methods
  func configure(_ location: String) {
    locationLabel.text = location
  }
}
