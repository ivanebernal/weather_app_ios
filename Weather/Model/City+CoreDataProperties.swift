//
//  City+CoreDataProperties.swift
//  Weather
//
//  Created by Ivan Esparza on 1/29/19.
//  Copyright © 2019 ivanebernal. All rights reserved.
//
//

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }

    @NSManaged public var country: String?
    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var coord: Coordinate?

}
