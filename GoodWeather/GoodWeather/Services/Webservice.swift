//
//  Webservice.swift
//  GoodWeather
//
//  Created by MinKyeongTae on 2022/10/17.
//

import Foundation
import Combine

struct Resource<T: Decodable> {
  let url: URL
  let parse: (Data) -> T?
}

final class Webservice {
  func loadWithCombine<T: Decodable>(resource: Resource<T>) -> AnyPublisher<T, Error> {
    return URLSession.shared.dataTaskPublisher(for: resource.url)
      .map(\.data)
      .decode(type: T.self, decoder: JSONDecoder())
      .receive(on: RunLoop.main)
      .eraseToAnyPublisher()
  }

  func load<T>(resource: Resource<T>, completion: @escaping (T?) -> Void) {
    URLSession.shared.dataTask(with: resource.url) { data, response, error in
      guard let data = data else {
        DispatchQueue.main.async {
          completion(nil)
        }
        return
      }
      DispatchQueue.main.async {
        completion(resource.parse(data)) // resource의 parse 클로져로 decoding을 진행
      }
    }
    .resume()
  }
}
