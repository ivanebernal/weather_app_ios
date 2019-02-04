//
//  HourForecasts.swift
//  Weather
//
//  Created by Ivan Esparza on 2/1/19.
//  Copyright © 2019 ivanebernal. All rights reserved.
//

import Foundation
import UIKit
class HourForecasts: UITableViewCell {
  static let name = String(describing: HourForecasts.self)
  static let identifier = "\(String(describing: HourForecasts.self))identifier"
  
  @IBOutlet weak var collectionView: UICollectionView!
  var forecast: Forecast5Days? {
    didSet {
      collectionView.reloadData()
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    collectionView.register(UINib(nibName: HourForecastCell.name, bundle: nil), forCellWithReuseIdentifier: HourForecastCell.identifier)
    collectionView.dataSource = self
    let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
    layout.itemSize = CGSize(width: frame.width / 8, height: collectionView.frame.height * 0.8)
    layout.scrollDirection = .horizontal
  }
}

extension HourForecasts: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return forecast?.list.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let rawCell = collectionView.dequeueReusableCell(withReuseIdentifier: HourForecastCell.identifier, for: indexPath)
    if let cell = rawCell as? HourForecastCell {
      cell.setupViews(forecast: forecast?.list[indexPath.row])
      return cell
    }
    return rawCell
  }
}
