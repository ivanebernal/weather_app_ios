//
//  BaseService.swift
//  Weather
//
//  Created by Ivan Esparza on 1/30/19.
//  Copyright © 2019 ivanebernal. All rights reserved.
//

import Foundation

enum ServiceRespose<Model> {
  case success(model: Model)
  case error(error: Error)
}

class BaseService {
  func make<Model: Codable>(request: URLRequest, completion: @escaping (ServiceRespose<Model>) -> Void){
    let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
      guard let strongSelf = self else { return }
      guard let response = response as? HTTPURLResponse, let data = data else {
        completion(.error(error: ServiceError.badURL))
        return
      }
      strongSelf.processResponse(data: data, response: response, completion: completion)
    }
    task.resume()
  }
  
  func processResponse<Model: Codable>(data: Data, response: HTTPURLResponse, completion: @escaping (ServiceRespose<Model>) -> Void) {
    switch response.statusCode {
    case 200:
      do{
        let responseModel: Model = try parse(data: data)
        completion(.success(model: responseModel))
      } catch let error {
        completion(.error(error: error))
      }
    default:
      completion(.error(error: ServiceError.badRequest))
    }
  }
  
  func parse<Model: Codable>(data: Data) throws -> Model {
    return try JSONDecoder().decode(Model.self, from: data)
  }
}
