//
//  Coordinate+CoreDataClass.swift
//  Weather
//
//  Created by Ivan Esparza on 1/29/19.
//  Copyright © 2019 ivanebernal. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Coordinate)
public class Coordinate: NSManagedObject, Codable {
  enum CodingKeys: String, CodingKey {
    case lat, lon
  }
  
  required convenience public init(from decoder: Decoder) throws {
    guard let context = CodingUserInfoKey.context,
    let managedObjectContext = decoder.userInfo[context] as? NSManagedObjectContext,
      let entity = NSEntityDescription.entity(forEntityName: "Coordinate", in: managedObjectContext) else {
        fatalError("Could not decode Coordinate!")
    }
    self.init(entity: entity, insertInto: managedObjectContext)
    let values = try decoder.container(keyedBy: CodingKeys.self)
    lat = try values.decode(Double.self, forKey: .lat)
    lon = try values.decode(Double.self, forKey: .lon)
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(lat, forKey: .lat)
    try container.encode(lon, forKey: .lon)
  }
}
