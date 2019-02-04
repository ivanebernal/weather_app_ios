//
//  CoreDataTransport.swift
//  Weather
//
//  Created by Ivan Esparza on 1/31/19.
//  Copyright © 2019 ivanebernal. All rights reserved.
//

import Foundation
import CoreData
import UIKit

protocol CoreDataTransport {
  func getCity(with id: Int) -> City?
}

class CoreDataTransportImpl: CoreDataTransport {
  let appDelegate = UIApplication.shared.delegate as! AppDelegate
  let container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
  
  func getCity(with id: Int) -> City? {
    let request = City.fetchRequest() as NSFetchRequest<City>
    request.predicate = NSPredicate(format: "id == %d", id)
    do {
      let cities = try container.viewContext.fetch(request)
      if !cities.isEmpty {
        return cities.first
      } else {
        return nil
      }
    } catch {
      return nil
    }
  }
}
