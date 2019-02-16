//
//  HourForecast.swift
//  Weather
//
//  Created by Ivan Esparza on 1/30/19.
//  Copyright © 2019 ivanebernal. All rights reserved.
//

import UIKit

class HourForecastCell: UICollectionViewCell {
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var temperatureLabel: UILabel!
  
  static let name = String(describing: HourForecastCell.self)
  static let identifier = "\(String(describing: HourForecastCell.self))identifier"
  
  func setupViews(forecast: WeatherCondition?) {
    guard let forecast = forecast else { return }
    let date = Date(timeIntervalSince1970: Double(forecast.dt))
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "hh a"
    timeLabel.text = dateFormatter.string(from: date)
    let temp = Int(forecast.main.temp.toCelsius().rounded()).description
    temperatureLabel.text = "\(temp)º"
    
    do {
      if let icon = forecast.weather.first?.icon{
        try iconImageView.loadImage(fromUrl: "https://openweathermap.org/img/w/\(icon).png")
      }
    } catch let error{
      print("Error: \(error.localizedDescription)")
    }
    
  }

}
