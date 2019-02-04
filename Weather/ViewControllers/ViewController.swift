//
//  ViewController.swift
//  Weather
//
//  Created by Ivan Esparza on 1/29/19.
//  Copyright © 2019 ivanebernal. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
  
  @IBOutlet weak var loadingStackView: UIStackView!
  let delegate = UIApplication.shared.delegate as! AppDelegate
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

  fileprivate func loadCities(completion: (() -> Void)?) {
    let parsingOperation = JSONParsingOperation()
    parsingOperation.completionBlock = {
      OperationQueue.main.addOperation {
        print("Cities Added")
        completion?()
      }
    }
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
    if let count = try? context.count(for: request), count == 0 {
      let opQ = OperationQueue()
      opQ.addOperation(parsingOperation)
    } else {
      self.loadingStackView.isHidden = true
      completion?()
    }
  }
  
  fileprivate func showMainScreen() {
    self.loadingStackView.isHidden = true
    let sb = UIStoryboard(name: "Weather", bundle: nil)
    guard let vc = sb.instantiateInitialViewController() else { return }
    vc.view.frame = view.bounds
    view.addSubview(vc.view)
    addChild(vc)
    vc.didMove(toParent: self)
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadCities {
      self.showMainScreen()
    }
  }


}

