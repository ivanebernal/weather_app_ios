//
//  LoadImageService.swift
//  Weather
//
//  Created by Ivan Esparza on 1/30/19.
//  Copyright © 2019 ivanebernal. All rights reserved.
//

import Foundation
import UIKit

class LoadImageService {
  static func loadImage(from url: String, completion: @escaping (UIImage?) -> Void){
    guard let url = URL(string: url) else {
      completion(nil)
      return
    }
    let request = URLRequest(url: url)
    if let cachedImage = URLCache.shared.cachedResponse(for: request),
      let image = UIImage(data: cachedImage.data) {
      completion(image)
      return
    }
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      guard let response = response,
      let rawData = data,
        let image = UIImage(data: rawData) else {
          completion(nil)
          return
      }
      URLCache.shared.storeCachedResponse(CachedURLResponse(response: response, data: rawData), for: request)
      completion(image)
    }
    task.resume()
  }
}
