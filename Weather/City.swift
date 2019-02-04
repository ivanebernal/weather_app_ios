//
//  City.swift
//  Weather
//
//  Created by Ivan Esparza on 1/29/19.
//  Copyright © 2019 ivanebernal. All rights reserved.
//

import Foundation

struct Coordinates: Codable {
  let lat: Float!
  let lon: Float!
}

struct City: Codable {
  let id: Int!
  let name: String!
  let country: String!
  let coordinates: Coordinates!
}
