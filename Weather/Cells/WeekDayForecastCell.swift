//
//  WeekDayForecastCell.swift
//  Weather
//
//  Created by Ivan Esparza on 1/31/19.
//  Copyright © 2019 ivanebernal. All rights reserved.
//

import Foundation
import UIKit

class WeekDayForecastCell: UITableViewCell {
  
  static let identifier = "\(String(describing: WeekDayForecastCell.self))identifier"
  static let name = String(describing: WeekDayForecastCell.self)
  
  @IBOutlet weak var weekDayLabel: UILabel!
  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var maxTempLabel: UILabel!
  @IBOutlet weak var minTempLabel: UILabel!
  
  func setupViews(weather: WeatherCondition) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    let date = Date(timeIntervalSince1970: Double(weather.dt))
    let maxTemp = Int(weather.main.temp_max.toCelsius().rounded())
    let minTemp = Int(weather.main.temp_min.toCelsius().rounded())
    weekDayLabel.text = dateFormatter.string(from: date)
    maxTempLabel.text = maxTemp.description
    minTempLabel.text = minTemp.description
    do {
      if let icon = weather.weather.first?.icon {
        try iconImageView.loadImage(fromUrl: "https://openweathermap.org/img/w/\(icon).png")
      }
    } catch let error {
      print("\(error.localizedDescription)")
    }
    
  }
  
}
