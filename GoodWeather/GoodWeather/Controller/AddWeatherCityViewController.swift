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
    
  }
  
  @IBAction func close() {
    self.dismiss(animated: true)
  }
}
