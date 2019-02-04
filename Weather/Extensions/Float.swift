//
//  Float.swift
//  Weather
//
//  Created by Ivan Esparza on 1/30/19.
//  Copyright © 2019 ivanebernal. All rights reserved.
//

import Foundation

extension Float {
  func toCelsius() -> Float {
    return self - 273.15
  }
  
  func toFahrenheit() -> Float {
    return (self - 273.15) * (9/5) + 32
  }
}
