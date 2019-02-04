//
//  Weather.swift
//  Weather
//
//  Created by Ivan Esparza on 1/30/19.
//  Copyright © 2019 ivanebernal. All rights reserved.
//

import Foundation

struct WeatherCondition: Codable {
  let coord: Coord?
  let weather: [Weather]
  let base: String?
  let main: Main
  let wind: Wind
  let clouds: Clouds
  let rain: [String: Float]?
  let snow: [String: Float]?
  let dt: Double
  let sys: Sys?
  let id: Int?
  let name: String?
  let cod: Int?
  let dt_txt: String?
}

struct Coord: Codable {
  let lon: Double
  let lat: Double
}
struct Weather: Codable {
  let id: Int
  let main: String
  let description: String
  let icon: String
}
struct Main: Codable {
  let temp: Float
  let pressure: Float
  let humidity: Float
  let temp_min: Float
  let temp_max: Float
  let sea_level: Float?
  let grnd_level: Float?
}
struct Wind: Codable {
  let speed: Float
  let deg: Float
}

struct Clouds: Codable {
  let all: Float
}

struct Sys: Codable {
  let message: Float?
  let country: String?
  let sunrise: Double?
  let sunset: Double?
  let pod: String?
}
