//
//  Endpoint.swift
//  Weather
//
//  Created by Ivan Esparza on 1/30/19.
//  Copyright © 2019 ivanebernal. All rights reserved.
//

import Foundation

protocol Endpoint {
  var host: Host { get }
  var path: String { get }
  var params: [String: String] { get }
}

enum Host: String {
  case main = "https://api.openweathermap.org"
  func getURL() -> URL? {
    return URL(string: self.rawValue)
  }
}

struct Endpoints {
  struct LocationWeather: Endpoint {
    init(lat: Double, lon: Double) {
      self.lat = lat
      self.lon = lon
    }
    let lat: Double
    let lon: Double
    let host: Host = .main
    var path: String {return "/data/2.5/weather"}
    var params: [String: String] {
      return [
        "lat": lat.description,
        "lon": lon.description,
        "appid": AppConstants.API_KEY
      ]
    }
  }
  struct Forecast5Days: Endpoint {
    init(lat: Double, lon: Double) {
      self.lat = lat
      self.lon = lon
    }
    let lat: Double
    let lon: Double
    let host: Host = .main
    var path: String { return "/data/2.5/forecast" }
    var params: [String : String] {
      return [
        "lat": lat.description,
        "lon": lon.description,
        "appid": AppConstants.API_KEY
      ]
    }
    
    
  }
}
