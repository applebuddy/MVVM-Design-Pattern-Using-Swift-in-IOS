//
//  WeatherListViewModel.swift
//  GoodWeather
//
//  Created by MinKyeongTae on 2022/10/17.
//

import Foundation

class WeatherListViewModel {
  
}

class WeatherViewModel {
  let weather: WeatherResponse
  
  init(weather: WeatherResponse) {
    self.weather = weather
  }
  
  var city: String {
    return weather.name
  }
  
  var temperature: Double {
    return weather.main.temp
  }
  
  var humidity: Double {
    return weather.main.humidity
  }
}

