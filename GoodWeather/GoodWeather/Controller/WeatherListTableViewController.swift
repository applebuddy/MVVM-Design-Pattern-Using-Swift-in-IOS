//
//  WeatherListTableViewController.swift
//  GoodWeather
//
//  Created by MinKyeongTae on 2022/10/17.
//

import UIKit
import Combine

class WeatherListTableViewController: UITableViewController {
  
  private var weatherListViewModel = WeatherListViewModel()
  private var lastUnitSelection: Unit!
  private var cancellables = Set<AnyCancellable>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.prefersLargeTitles = true
    self.tableView.separatorStyle = .singleLine
    self.tableView.separatorColor = .white
    
    let rawValue = UserDefaults.standard.value(forKey: "unit") as? String
    self.lastUnitSelection = Unit(rawValue: rawValue ?? "") ?? Unit.fahrenheit
    /*
    let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=houston&appid=83ac5aa4b3c35a75018e9ffe83d7060d")!
    let resource = Resource<WeatherResponse>(url: url) { data in
      return try? JSONDecoder().decode(WeatherResponse.self, from: data)
    }
    
    Webservice().load(resource: resource) { weatherResponse in
      guard let weatherResponse = weatherResponse else {
        return
      }
      print(weatherResponse)
    }
     */
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return weatherListViewModel.numberOfRows(section)
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherCell else {
      return UITableViewCell()
    }
    let weatherViewModel = weatherListViewModel.modelAt(indexPath.row)
    cell.configureCell(weatherViewModel)
    // cell.cityNameLabel.text = weatherModel.city
    // cell.temperatureLabel.text = "\(weatherModel.temperature)"
    return cell
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "AddWeatherCityViewController" {
      prepareSegueAddWeatherCityViewController(segue: segue)
    } else if segue.identifier == "SettingsTableViewController" {
      prepareSegueForSettingsTableViewController(segue: segue)
    }
    
  }
  
  private func prepareSegueAddWeatherCityViewController(segue: UIStoryboardSegue) {
    guard let navigationController = segue.destination as? UINavigationController,
          let addWeatherCityViewController = navigationController.viewControllers.first as? AddWeatherCityViewController else {
      fatalError("there's no AddWeatherCityViewController")
    }
    
    addWeatherCityViewController.addWeatherDidSaveSubject
      .receive(on: RunLoop.main)
      .sink { [weak self] viewModel in
        self?.weatherListViewModel.addWeatherViewModel(viewModel)
        self?.tableView.reloadData()
        print("addWeatherDidSave : \(viewModel)")
      }
      .store(in: &cancellables)
    
    /*
    addWeatherCityViewController.delegate = self
    */
  }
  
  private func prepareSegueForSettingsTableViewController(segue: UIStoryboardSegue) {
    guard let navigationController = segue.destination as? UINavigationController,
          let appSettingTableViewController = navigationController.viewControllers.first as? AppSettingTableViewController else {
      fatalError("There's no AppSettingTableViewController")
    }
    
    appSettingTableViewController.settingDoneSubject
      .receive(on: RunLoop.main)
      .sink { [weak self] viewModel in
        // 변동이 있으면 업데이트 실행
        guard self?.lastUnitSelection.rawValue != viewModel.selectedUnit.rawValue else {
          return
        }
        self?.weatherListViewModel.updateUnit(to: viewModel.selectedUnit)
        self?.tableView.reloadData()
        self?.lastUnitSelection = Unit(rawValue: viewModel.selectedUnit.rawValue)!
      }
      .store(in: &cancellables)
    /*
    appSettingTableViewController.delegate = self
     */
  }
}

/*
extension WeatherListTableViewController: AddWeatherDelegate {
  func addWeatherDidSave(viewModel: WeatherViewModel) {
    weatherListViewModel.addWeatherViewModel(viewModel)
    self.tableView.reloadData()
    print("addWeatherDidSave : \(viewModel)")
  }
}
*/

/*
extension WeatherListTableViewController: SettingsDelegate {
  func settingsDone(viewModel: SettingsViewModel) {
    // 변동이 있으면 업데이트 실행
    if lastUnitSelection.rawValue != viewModel.selectedUnit.rawValue {
      weatherListViewModel.updateUnit(to: viewModel.selectedUnit)
      tableView.reloadData()
      lastUnitSelection = Unit(rawValue: viewModel.selectedUnit.rawValue)!
    }
  }
}
*/
