//
//  UIImageView.swift
//  Weather
//
//  Created by Ivan Esparza on 1/30/19.
//  Copyright © 2019 ivanebernal. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
  func loadImage(fromUrl url: String) throws {
    LoadImageService.loadImage(from: url) { [weak self] (image) in
      guard let strongSelf = self else { return } //Ask about this
      OperationQueue.main.addOperation {
        strongSelf.image = image
      }
    }
    
  }
}
