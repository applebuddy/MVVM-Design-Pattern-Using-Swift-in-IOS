//
//  AddWeatherViewModel.swift
//  GoodWeather
//
//  Created by MinKyeongTae on 2022/10/17.
//

import Foundation
import Combine

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
  
  /// Combine 을 사용하여 API 요청, 응답 실행
  func addWeatherWithCombine(for city: String) -> AnyPublisher<WeatherViewModel, Error> {
    let weatherURL = Constants.URLs.urlForWeatherByCity(city: city)
    let weatherResource = Resource<WeatherResponse>(url: weatherURL) { _ in
      // combine 사용 시엔 해당 클로져 사용 안함...
      return nil
    }
    // Combine활용한 API 요청
    return Webservice().loadWithCombine(resource: weatherResource)
      .map { weatherResponse -> WeatherViewModel in
        return WeatherViewModel(weather: weatherResponse)
      }
      .eraseToAnyPublisher()
  }
}
