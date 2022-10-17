//
//  WeatherResponse.swift
//  GoodWeather
//
//  Created by MinKyeongTae on 2022/10/17.
//

import Foundation

struct WeatherResponse: Decodable {
  let name: String
  let main: Weather
}

struct Weather: Decodable {
  let temp: Double
  let humidity: Double
}
