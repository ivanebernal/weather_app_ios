//
//  WeatherViewController.swift
//  Weather
//
//  Created by Ivan Esparza on 1/30/19.
//  Copyright © 2019 ivanebernal. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

protocol WeatherPresenter: class {
  func configureMainViews(data: MainWeatherData)
  func configureHourForecast(forecast: Forecast5Days)
  func configureDayConditions(conditions: [((String, String), (String, String))])
  func setWeekForecast(forecast: [WeatherCondition])
}

class WeatherViewController: UIViewController {
  
  //MARK: - Outlets
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var header: WeatherHeaderView!
  
  //MARK: - Properties
  var locationManager: CLLocationManager = CLLocationManager()
  var controller: WeatherController?
  var forecast: Forecast5Days? {
    didSet {
      tableView.reloadData()
    }
  }
  var dayConditions: [((String, String), (String, String))] = [] {
    didSet {
      tableView.reloadData()
    }
  }
  var weekForecast: [WeatherCondition] = [] {
    didSet {
      tableView.reloadData()
    }
  }
  
  //MARK: - UIViewController methods
  override func viewDidLoad() {
    super.viewDidLoad()
    Bundle.main.loadNibNamed(WeatherHeaderView.name, owner: self, options: nil)
    configureTableView()
    controller = WeatherController(view: self)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    checkForLocationServices()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    sizeHeaderToFit()
  }
  
  //MARK: - Private Methods
  
  fileprivate func checkForLocationServices() {
    if CLLocationManager.locationServicesEnabled() {
      locationManager.delegate = self
      locationManager.distanceFilter = 3.0
      locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
      locationManager.requestWhenInUseAuthorization()
      locationManager.requestLocation()
    } else {
      //TODO
    }
  }
  
  
  fileprivate func configureTableView() {
    tableView.register(UINib(nibName: HourForecasts.name, bundle: nil), forCellReuseIdentifier: HourForecasts.identifier)
    tableView.register(UINib(nibName: DayAndWeekDataCell.name, bundle: nil), forCellReuseIdentifier: DayAndWeekDataCell.identifier)
    tableView.tableHeaderView = header
    header.setNeedsLayout()
    header.layoutIfNeeded()
    tableView.dataSource = self
    tableView.delegate = self
    
  }
  
  fileprivate func sizeHeaderToFit() {
    header.setNeedsLayout()
    header.layoutIfNeeded()
    let height = header.systemLayoutSizeFitting(UIView.layoutFittingExpandedSize).height
    var frame = header.frame
    frame.size.height = height
    header.frame = frame
    tableView.tableHeaderView = header
  }
}

//MARK: - Delegates
extension WeatherViewController: CLLocationManagerDelegate {
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let coordinate = locations.last?.coordinate else { return }
    controller?.fetchWeatherData(lat: coordinate.latitude, lon: coordinate.longitude)
  }
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//    if status == .authorizedWhenInUse {
//      guard let coordinate = locationManager.location?.coordinate else { return }
//      fetchWeatherData(coordinate)
//    }
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("Location Manager Error \(error.localizedDescription)")
  }
}

extension WeatherViewController: WeatherPresenter {
  func configureMainViews(data: MainWeatherData) {
    OperationQueue.main.addOperation {
      self.header.setUpViews(data: data)
    }
  }
  
  func configureHourForecast(forecast: Forecast5Days) {
    OperationQueue.main.addOperation {
      self.forecast = forecast
    }
  }
  
  func configureDayConditions(conditions: [((String, String), (String, String))]) {
    OperationQueue.main.addOperation {
      self.dayConditions = conditions
    }
  }
  
  func setWeekForecast(forecast: [WeatherCondition]) {
    OperationQueue.main.addOperation {
      self.weekForecast = forecast
    }
  }
}

extension WeatherViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.row {
    case 0:
      let cell = tableView.dequeueReusableCell(withIdentifier: HourForecasts.identifier) as! HourForecasts
      cell.forecast = forecast
      return cell
    case 1:
      let cell = tableView.dequeueReusableCell(withIdentifier: DayAndWeekDataCell.identifier) as! DayAndWeekDataCell
      cell.dayConditionParams = dayConditions
      cell.weekForecast = weekForecast
      return cell
    default:
      fatalError("Invalid number of cells")
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //Header height 230
    switch indexPath.row {
    case 0:
      return 150
    case 1:
      let weekForecastHeight = 300
      let dayConditionsHeight = 240 + 60
      return CGFloat(weekForecastHeight + dayConditionsHeight) - 150
    default:
      return 0
    }
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView.contentSize.height > view.frame.height && UIDevice.current.orientation.isPortrait {
      header.adjustToScroll(dy: scrollView.contentOffset.y, possibleOffset: scrollView.frame.height - view.bounds.height)
    }
  }
}

