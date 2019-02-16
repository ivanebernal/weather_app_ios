//
//  DayConditionsCell.swift
//  Weather
//
//  Created by Ivan Esparza on 1/31/19.
//  Copyright © 2019 ivanebernal. All rights reserved.
//

import Foundation
import UIKit

class DayConditionsCell: UITableViewCell {
  static let name = String(describing: DayConditionsCell.self)
  static let identifier = "\(String(describing: DayConditionsCell.self))identifier"
  
  @IBOutlet weak var condition1TitleLabel: UILabel!
  @IBOutlet weak var condition1ValueLabel: UILabel!
  @IBOutlet weak var condition2TitleLabel: UILabel!
  @IBOutlet weak var condition2ValueLabel: UILabel!
  
  func setupValues(conditions: ((String, String), (String, String))) {
    condition1TitleLabel.text = conditions.0.0.capitalized
    condition1ValueLabel.text = conditions.0.1
    condition2TitleLabel.text = conditions.1.0.capitalized
    condition2ValueLabel.text = conditions.1.1
  }
  
}
