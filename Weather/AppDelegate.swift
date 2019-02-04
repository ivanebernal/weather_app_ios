//
//  AppDelegate.swift
//  Weather
//
//  Created by Ivan Esparza on 1/29/19.
//  Copyright © 2019 ivanebernal. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "Weather")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      print(storeDescription)
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
  func saveContext() {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let error = error as NSError
        fatalError("Unresolved error: \(error), \(error.userInfo)")
      }
    }
  }


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    return true
  }


}

