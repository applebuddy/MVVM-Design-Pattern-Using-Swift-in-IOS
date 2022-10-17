//
//  AddWeatherCityViewController.swift
//  GoodWeather
//
//  Created by MinKyeongTae on 2022/10/17.
//

import UIKit

class AddWeatherCityViewController: UIViewController {
  @IBOutlet weak var cityNameTextField: UITextField!

  // MARK: - Action

  @IBAction func saveCityButtonPressted() {
    let apiKey = "83ac5aa4b3c35a75018e9ffe83d7060d"
    guard let city = cityNameTextField.text,
          let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&APPID=\(apiKey)") else {
      return
    }
    let weatherResource = Resource<Any>(url: weatherURL, parse: { data in
      return data
    })
    Webservice().load(resource: weatherResource, completion: { result in
      
    })
    
  }
  
  @IBAction func close() {
    self.dismiss(animated: true)
  }
}
