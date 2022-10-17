//
//  Constants.swift
//  GoodWeather
//
//  Created by MinKyeongTae on 2022/10/17.
//

import Foundation

struct Constants {
  struct URLs {
    static func urlForWeatherByCity(city: String) -> URL {
      return URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(city.escaped())&appid=83ac5aa4b3c35a75018e9ffe83d7060d&units=imperial")!
    }
  }
}
