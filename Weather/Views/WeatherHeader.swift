//
//  WeatherHeader.swift
//  Weather
//
//  Created by Ivan Esparza on 2/1/19.
//  Copyright © 2019 ivanebernal. All rights reserved.
//

import Foundation
import UIKit
class WeatherHeaderView: UIView {
  static let name = String(describing: WeatherHeaderView.self)
  
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var mainDescriptionLabel: UILabel!
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet weak var dayOfWeekLabel: UILabel!
  @IBOutlet weak var dayMaxTempLabel: UILabel!
  @IBOutlet weak var dayMinTempLabel: UILabel!
  @IBOutlet weak var mainInfoView: UIView!
  @IBOutlet weak var dayInfoStackView: UIStackView!
  var oldOffset: CGFloat = 0
  
  func setUpViews(data: MainWeatherData){
    temperatureLabel.text = "\(data.dayTemp)º" //TODO: Support fahrenheit
    cityLabel.text = data.cityName
    mainDescriptionLabel.text = data.description
    dayMaxTempLabel.text = "\(data.maxTemp)º"
    dayMinTempLabel.text = "\(data.minTemp)º"
    dayOfWeekLabel.text = data.weekDay
  }
  
  func adjustToScroll(dy: CGFloat, possibleOffset: CGFloat) {
    let movement = dy - oldOffset
    let movPercent = (dy / 2 )/abs(possibleOffset * 0.8)
    let yPosition = mainInfoView.convert(mainInfoView.frame, to: self).minY
    
    if dy < 150 && dy > 0 {
      if yPosition + movement > 4 {
        mainInfoView.frame = mainInfoView.frame.inset(by: UIEdgeInsets(top: movement * 1.3, left: 0, bottom: 0, right: 0))
        oldOffset = dy
      }
      UIView.animate(withDuration: 0) {
        self.dayInfoStackView.alpha = 1.3 - movPercent
        self.temperatureLabel.alpha = 1.3 - movPercent
      }
    }
  }
}
