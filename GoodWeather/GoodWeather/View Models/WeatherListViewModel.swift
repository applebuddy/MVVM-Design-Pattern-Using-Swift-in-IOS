//
//  WeatherListViewModel.swift
//  GoodWeather
//
//  Created by MinKyeongTae on 2022/10/17.
//

import Foundation

class WeatherListViewModel {
  private var weatherViewModels = [WeatherViewModel]()
  
  func addWeatherViewModel(_ viewModel: WeatherViewModel) {
    weatherViewModels.append(viewModel)
  }
  
  func numberOfRows(_ section: Int) -> Int {
    return weatherViewModels.count
  }
  
  func modelAt(_ index: Int) -> WeatherViewModel {
    return weatherViewModels[index]
  }
  
  /// 섭씨로 변환
  private func toCelsius() {
    weatherViewModels = weatherViewModels.map { viewModel in
      let weatherModel = viewModel
      weatherModel.temperature = (weatherModel.temperature - 32) * 5 / 9
      return weatherModel
    }
  }
  
  /// 화씨로 변환
  private func toFahrenheit() {
    weatherViewModels = weatherViewModels.map { viewModel in
      let weatherModel = viewModel
      weatherModel.temperature = (weatherModel.temperature * 9 / 5) + 32
      return weatherModel
    }
  }
  
  func updateUnit(to unit: Unit) {
    switch unit {
    case .celsius:
      toCelsius()
    case .fahrenheit:
      toFahrenheit()
    }
  }
}

class WeatherViewModel {
  let weather: WeatherResponse
  var temperature: Double
  
  init(weather: WeatherResponse) {
    self.weather = weather
    temperature = weather.main.temp
  }
  
  var city: String {
    return weather.name
  }
}

