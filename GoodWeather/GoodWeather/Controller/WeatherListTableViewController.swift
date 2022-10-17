//
//  WeatherListTableViewController.swift
//  GoodWeather
//
//  Created by MinKyeongTae on 2022/10/17.
//

import Foundation
import UIKit

class WeatherListTableViewController: UITableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.prefersLargeTitles = true
    self.tableView.separatorStyle = .singleLine
    self.tableView.separatorColor = .white
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
    return 1
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherCell else {
      return UITableViewCell()
    }
    cell.cityNameLabel.text = "Houston"
    cell.temperatureLabel.text = "70"
    return cell
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "AddWeatherCityViewController" {
      prepareSegueAddWeatherCityViewController(segue: segue)
    }
    
  }
  
  private func prepareSegueAddWeatherCityViewController(segue: UIStoryboardSegue) {
    guard let navigationController = segue.destination as? UINavigationController,
          let addWeatherCityViewController = navigationController.viewControllers.first as? AddWeatherCityViewController else {
      fatalError("there's no AddWeatherCityViewController")
    }
    
    addWeatherCityViewController.delegate = self
  }
}

extension WeatherListTableViewController: AddWeatherDelegate {
  func addWeatherDidSave(viewModel: WeatherViewModel) {
    print("addWeatherDidSave : \(viewModel)")
  }
}
