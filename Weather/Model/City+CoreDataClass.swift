//
//  City+CoreDataClass.swift
//  Weather
//
//  Created by Ivan Esparza on 1/29/19.
//  Copyright © 2019 ivanebernal. All rights reserved.
//
//

import Foundation
import CoreData

@objc(City)
public class City: NSManagedObject, Codable {
  enum CodingKeys: String, CodingKey {
    case name, id, country, coord
  }
  
  required convenience public init(from decoder: Decoder) throws {
    guard let contextUserInfoKey = CodingUserInfoKey.context,
    let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
      let entity = NSEntityDescription.entity(forEntityName: "City", in: managedObjectContext) else {
        fatalError("Failed to decode City!")
    }
    self.init(entity: entity, insertInto: managedObjectContext)
    let values = try decoder.container(keyedBy: CodingKeys.self)
    name = try! values.decode(String.self, forKey: .name)
    id = try! values.decode(Int32.self, forKey: .id)
    country = try! values.decode(String.self, forKey: .country)
    coord = try? values.decode(Coordinate.self, forKey: .coord)
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(name, forKey: .name)
    try container.encode(id, forKey: .id)
    try container.encode(country, forKey: .country)
    try container.encode(coord, forKey: .coord)
  }

}
