//
//  AddWeatherViewModel.swift
//  GoodWeather
//
//  Created by MinKyeongTae on 2022/10/17.
//

import Foundation

class AddWeatherViewModel {
  func addWeather(for city: String, completion: @escaping (WeatherViewModel) -> Void) {
    let weatherURL = Constants.URLs.urlForWeatherByCity(city: city)
    let weatherResource = Resource<WeatherResponse>(url: weatherURL) { data -> WeatherResponse? in
      let response = try? JSONDecoder().decode(WeatherResponse.self, from: data)
      return response
    }
    
    Webservice().load(resource: weatherResource) { result in
      if let response = result {
        let viewModel = WeatherViewModel(weather: response)
        completion(viewModel)
      }
    }
  }
}
