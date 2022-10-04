//
//  URLSession+Extension.swift
//  NewsApp
//
//  Created by MinKyeongTae on 2022/10/04.
//

import Foundation
import Combine

extension URLSession {
  static func loadWithCombine<T>(resource: Resource<T>) -> AnyPublisher<T, Never> {
    return self.shared.dataTaskPublisher(for: resource.url)
      .map(\.data)
      .decode(type: T.self, decoder: JSONDecoder())
      .catch { _ in return Empty<T, Never>() }
      .receive(on: RunLoop.main)
      .eraseToAnyPublisher()
  }
}
