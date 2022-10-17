//
//  Webservice.swift
//  GoodWeather
//
//  Created by MinKyeongTae on 2022/10/17.
//

import Foundation

struct Resource<T> {
  let url: URL
  let parse: (Data) -> T?
}

final class Webservice {
  func load<T>(resource: Resource<T>, completion: @escaping (T?) -> Void) {
    URLSession.shared.dataTask(with: resource.url) { data, response, error in
      print(data)
      guard let data = data else {
        DispatchQueue.main.async {
          completion(nil)
        }
        return
      }
      DispatchQueue.main.async {
        completion(resource.parse(data))
      }
    }
    .resume()
  }
}
