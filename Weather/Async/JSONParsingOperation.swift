//
//  JSONParsingOperation.swift
//  Weather
//
//  Created by Ivan Esparza on 1/29/19.
//  Copyright © 2019 ivanebernal. All rights reserved.
//

import Foundation
import UIKit

class JSONParsingOperation: AsyncOperation {
  
  var cities: [City]?
  var container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
  
  override func main() {
    let filepath = Bundle.main.url(forResource: "city.list", withExtension: "json")
    if let path = filepath, let reachable = try? path.checkResourceIsReachable(), reachable {
      do{
        let data = try Data(contentsOf: path)
        let decoder = JSONDecoder()
        let context = container.newBackgroundContext()
        decoder.userInfo[CodingUserInfoKey.context!] = context
        cities = try decoder.decode([City].self, from: data)
        try context.save()
        state = .Finished
      } catch let error as NSError {
        print("Error \(error.localizedDescription)")
        state = .Finished
      }
      
    }
  }
}
