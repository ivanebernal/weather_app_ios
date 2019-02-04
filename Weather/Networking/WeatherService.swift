//
//  WeatherService.swift
//  Weather
//
//  Created by Ivan Esparza on 1/30/19.
//  Copyright © 2019 ivanebernal. All rights reserved.
//

import Foundation

protocol WeatherService {
  func getWeatherByLocation(lat: Double, lon: Double, completion: @escaping (ServiceRespose<WeatherCondition>) -> Void)
  func getForecastByLocation(lat: Double, lon: Double, completion: @escaping (ServiceRespose<Forecast5Days>) -> Void)
}

class WeatherServiceImpl: BaseService, WeatherService {
  
  func getWeatherByLocation(lat: Double, lon: Double, completion: @escaping (ServiceRespose<WeatherCondition>) -> Void) {
    do{
      let endpoint = Endpoints.LocationWeather(lat: lat, lon: lon)
      let request = try RequestFactory.make(.get, endpoint: endpoint)
      make(request: request, completion: completion)
    } catch let error as NSError {
      completion(.error(error: error))
    }
  }
  
  func getForecastByLocation(lat: Double, lon: Double, completion: @escaping (ServiceRespose<Forecast5Days>) -> Void) {
    do{
      let endpoint = Endpoints.Forecast5Days(lat: lat, lon: lon)
      let request = try RequestFactory.make(.get, endpoint: endpoint)
      make(request: request, completion: completion)
    } catch let error as NSError {
      completion(.error(error: error))
    }
  }
}
