//
//  Forecast5Days.swift
//  Weather
//
//  Created by Ivan Esparza on 1/31/19.
//  Copyright © 2019 ivanebernal. All rights reserved.
//

import Foundation

struct Forecast5Days: Codable {
  let cod: String
  let message: Double
//  let city: City //TODO: check what happens when parsed here
  let cnt: Int
  let list: [WeatherCondition]
}
