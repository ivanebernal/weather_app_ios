//
//  DayAndWeekDataCell.swift
//  Weather
//
//  Created by Ivan Esparza on 2/1/19.
//  Copyright © 2019 ivanebernal. All rights reserved.
//

import UIKit

class DayAndWeekDataCell: UITableViewCell {
  
  static let name = String(describing: DayAndWeekDataCell.self)
  static let identifier = "\(String(describing: DayAndWeekDataCell.self))identifier"
  
  @IBOutlet weak var tableView: UITableView!
  
  var dayConditionParams: [((String, String), (String, String))] = [] {
    didSet {
      tableView.reloadData()
    }
  }
  var weekForecast: [WeatherCondition] = [] {
    didSet {
      tableView.reloadData()
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    tableView.dataSource = self
    tableView.delegate = self
    tableView.allowsSelection = false
    tableView.register(UINib(nibName: DayConditions.name, bundle: nil), forCellReuseIdentifier: DayConditions.identifier)
    tableView.register(UINib(nibName: WeekConditions.name, bundle: nil), forCellReuseIdentifier: WeekConditions.identifier)
  }

}

extension DayAndWeekDataCell: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.row {
    case 0:
      let cell = tableView.dequeueReusableCell(withIdentifier: WeekConditions.identifier) as! WeekConditions
      cell.weekForecast = weekForecast
      return cell
    case 1:
      let cell = tableView.dequeueReusableCell(withIdentifier: DayConditions.identifier) as! DayConditions
      cell.conditions = dayConditionParams
      return cell
    default:
      fatalError("Invalid number of cells")
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    switch indexPath.row {
    case 0:
      return CGFloat(weekForecast.count * 60)
    case 1:
      return CGFloat(dayConditionParams.count * 80) + 60
    default:
      return 0
    }
  }
  
}
