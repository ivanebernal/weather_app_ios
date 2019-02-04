//
//  WeatherController.swift
//  Weather
//
//  Created by Ivan Esparza on 1/31/19.
//  Copyright © 2019 ivanebernal. All rights reserved.
//

import Foundation

enum DateInfo: String {
  case hour = "hh:mm a"
  case weekDay = "EEEE"
}

class WeatherController {
  weak var weatherView: WeatherView?
  let weatherService: WeatherService = WeatherServiceImpl()
  let coreDataTransport: CoreDataTransport = CoreDataTransportImpl()
  
  init(view: WeatherView) {
    self.weatherView = view
  }
  
  func fetchWeatherData(lat: Double, lon: Double) {
    weatherService.getWeatherByLocation(lat: lat, lon: lon) { [weak self] (response) in
      guard let strongSelf = self else { return }
      switch response {
      case .success(let conditions):
        let data = strongSelf.getMainWeatherData(from: conditions)
        strongSelf.weatherView?.configureMainViews(data: data)
        let dayConditions = strongSelf.getDayConditions(from: conditions)
        strongSelf.weatherView?.configureDayConditions(conditions: dayConditions)
      case .error(let error):
        print("Error: \(error.localizedDescription)")
      }
    }
    weatherService.getForecastByLocation(lat: lat, lon: lon) { [weak self] (response) in
      guard let strongSelf = self else { return }
      switch response{
      case .success(let forecast):
        strongSelf.weatherView?.configureHourForecast(forecast: forecast)
        let weekForecast = strongSelf.parseForecast(forecast)
        strongSelf.weatherView?.setWeekForecast(forecast: weekForecast)
      case .error(let error):
        print("Error: \(error.localizedDescription)")
      }
      
    }
  }
  
  func parseForecast(_ forecast: Forecast5Days) -> [WeatherCondition] {
    let formatter = DateFormatter()
    let today = Date(timeIntervalSinceNow: 0)
    var weekDay = formatter.string(from: today)
    formatter.dateFormat = "EEEE"
    let weekForecast = forecast.list.filter { (condition) -> Bool in
      let date = Date(timeIntervalSince1970: Double(condition.dt))
      let forecastWeekDay = formatter.string(from: date)
      let include = forecastWeekDay != weekDay
      weekDay = forecastWeekDay
      return include
    }
    return weekForecast
  }
  
  fileprivate func getMainWeatherData(from conditions: WeatherCondition)-> MainWeatherData {
    let dayTemp = Int(conditions.main.temp.toCelsius().rounded()).description
    let maxTemp = Int(conditions.main.temp_max.toCelsius().rounded()).description
    let minTemp = Int(conditions.main.temp_min.toCelsius().rounded()).description
    let weekDay = getDateInfo(from: conditions.dt, type: .weekDay) ?? "-"
    let description = conditions.weather.first?.description ?? "-"
    var cityName = "--"
    if let id = conditions.id,
      let city = coreDataTransport.getCity(with: id),
      let name = city.name{
       cityName = name
    }
    return MainWeatherData(dayTemp: dayTemp, maxTemp: maxTemp, minTemp: minTemp, weekDay: weekDay, cityName: cityName, description: description)
  }
  
  fileprivate func getDayConditions(from conditions: WeatherCondition) -> [((String, String), (String, String))]{
    var dayConditions: [((String, String), (String, String))] = []
    let sunrise = getDateInfo(from: conditions.sys?.sunrise, type: .hour) ?? "-"
    let sunset = getDateInfo(from: conditions.sys?.sunset, type: .hour) ?? "-"
    let humidity = "\(Int(conditions.main.humidity.rounded()))%"
    let pressure = "\(Int(conditions.main.pressure.rounded())) hPa"
    let windDirection = getWindDirection(with: conditions.wind.deg) ?? ""
    let windSpeed = conditions.wind.speed
    let wind = "\(windDirection) \(windSpeed) km/h"
    let cloudiness = "\(conditions.clouds.all)%"
    dayConditions.append((("sunrise", sunrise), ("sunset", sunset)))
    dayConditions.append((("humidity", humidity), ("pressure", pressure)))
    dayConditions.append((("wind", wind), ("cloudiness", cloudiness)))
    return dayConditions
  }
  
  fileprivate func getDateInfo(from millis: Double?, type: DateInfo) -> String? {
    guard let millis = millis else { return nil }
    let date = Date(timeIntervalSince1970: millis)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = type.rawValue
    return dateFormatter.string(from: date)
  }
  
  fileprivate func getWindDirection(with degrees: Float?) -> String? {
    guard let degrees = degrees else { return nil }
    switch degrees  {
    case 0..<11.25, 348.75...360:
      return "N"
    case 11.25..<33.75:
      return "NNE"
    case 33.75..<56.25:
      return "NE"
    case 56.25..<78.75:
      return "ENE"
    case 78.75..<101.25:
      return "E"
    case 101.25..<123.75:
      return "ESE"
    case 123.75..<146.25:
      return "SE"
    case 146.25..<168.75:
      return "SSE"
    case 168.75..<191.25:
      return "S"
    case 191.25..<213.75:
      return "SSW"
    case 213.75..<236.25:
      return "SW"
    case 236.25..<258.75:
      return "WSW"
    case 258.75..<281.25:
      return "W"
    case 281.25..<303.75:
      return "WNW"
    case 303.75..<326.25:
      return "NW"
    case 326.25..<348.75:
      return "NNW"
    default:
      fatalError("Value out of range. Actual: \(degrees) expected value between 0 and 360")
    }
  }
  
}
