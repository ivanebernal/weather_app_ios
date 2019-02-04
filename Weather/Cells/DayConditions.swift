//
//  DayConditions.swift
//  Weather
//
//  Created by Ivan Esparza on 2/1/19.
//  Copyright © 2019 ivanebernal. All rights reserved.
//

import UIKit

class DayConditions: UITableViewCell {
  
  static let name = String(describing: DayConditions.self)
  static let identifier = "\(String(describing: DayConditions.self))identifier"

  var conditions: [((String, String), (String, String))] = [] {
    didSet {
      tableView.reloadData()
    }
  }
  
  @IBOutlet weak var tableView: UITableView!
  override func awakeFromNib() {
    super.awakeFromNib()
    let header = UILabel(frame: CGRect(x: 8, y: 0, width: frame.width - 16, height: 60))
    header.numberOfLines = 0
    header.text = "Tonight is cloudy. The max temperature will be of 20º and the min will be of 9º"
    tableView.register(UINib(nibName: DayConditionsCell.name, bundle: nil), forCellReuseIdentifier: DayConditionsCell.identifier)
    tableView.tableHeaderView = header
    tableView.rowHeight = 80
    tableView.allowsSelection = false
    tableView.dataSource = self
  }
    
}

extension DayConditions: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return conditions.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let rawCell = tableView.dequeueReusableCell(withIdentifier: DayConditionsCell.identifier)!
    if let cell = rawCell as? DayConditionsCell {
      cell.setupValues(conditions: conditions[indexPath.row])
    }
    return rawCell
  }
}


