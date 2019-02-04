//
//  RequestFactory.swift
//  Weather
//
//  Created by Ivan Esparza on 1/30/19.
//  Copyright © 2019 ivanebernal. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case delete = "DELETE"
}

enum RequestFactoryError: Error {
  case makeFailure
}

class RequestFactory {
  struct Constants {
    static let defaultTimeout: Double = 30
  }
  
  static func make(_ method: HTTPMethod, endpoint: Endpoint, timeout: Double = Constants.defaultTimeout) throws -> URLRequest{
    guard let baseURL = endpoint.host.getURL(),
      var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false) else {
      throw RequestFactoryError.makeFailure
    }
    components.path = endpoint.path
    components.queryItems = endpoint.params.map { param, value in
      return URLQueryItem(name: param, value: value)
    }
    var request = URLRequest(url: components.url ?? baseURL)
    request.httpMethod = method.rawValue
    request.timeoutInterval = timeout
    return request
  }
}
