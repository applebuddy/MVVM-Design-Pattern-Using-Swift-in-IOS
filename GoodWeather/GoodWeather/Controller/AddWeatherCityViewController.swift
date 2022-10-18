//
//  AddWeatherCityViewController.swift
//  GoodWeather
//
//  Created by MinKyeongTae on 2022/10/17.
//

import UIKit
import Combine

protocol AddWeatherDelegate {
  func addWeatherDidSave(viewModel: WeatherViewModel)
}

class AddWeatherCityViewController: UIViewController {
  @IBOutlet weak var cityNameTextField: UITextField!
  private var cancellables = Set<AnyCancellable>()
  
  private var addWeatherViewModel = AddWeatherViewModel()
  var delegate: AddWeatherDelegate?

  // MARK: - Action

  @IBAction func saveCityButtonPressted() {
    guard let city = cityNameTextField.text else {
      return
    }

    /*
    addWeatherViewModel.addWeather(for: city) { [weak self] viewModel in
      self?.delegate?.addWeatherDidSave(viewModel: viewModel)
      self?.dismiss(animated: true)
    }
     */
    
    // Combine 사용 시
    addWeatherViewModel.addWeatherWithCombine(for: city)
      .sink { completion in
        debugPrint(completion)
      } receiveValue: { [weak self] viewModel in
        self?.delegate?.addWeatherDidSave(viewModel: viewModel)
        self?.dismiss(animated: true)
      }
      .store(in: &cancellables)
  }
  
  @IBAction func close() {
    self.dismiss(animated: true)
  }
}
