//
//  WeekConditions.swift
//  Weather
//
//  Created by Ivan Esparza on 2/1/19.
//  Copyright © 2019 ivanebernal. All rights reserved.
//

import UIKit

class WeekConditions: UITableViewCell {
  
  static let name = String(describing: WeekConditions.self)
  static let identifier = "\(String(describing: WeekConditions.self))identifier"

  @IBOutlet weak var tableView: UITableView!
  
  var weekForecast: [WeatherCondition] = [] {
    didSet {
      tableView.reloadData()
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    tableView.dataSource = self
    tableView.allowsSelection = false
    tableView.rowHeight = 60
    tableView.register(UINib(nibName: WeekDayForecastCell.name, bundle: nil), forCellReuseIdentifier: WeekDayForecastCell.identifier)
  }
  
  func setWeekForecast(forecast: [WeatherCondition]) {
    weekForecast = forecast
    tableView.reloadData()
  }
    
}

extension WeekConditions: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return weekForecast.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let rawCell = tableView.dequeueReusableCell(withIdentifier: WeekDayForecastCell.identifier)!
    if let cell = rawCell as? WeekDayForecastCell {
      cell.setupViews(weather: weekForecast[indexPath.row])
      return cell
    }
    return rawCell
  }
}

