//
//  Webservice.swift
//  HotCoffee
//
//  Created by MinKyeongTae on 2022/10/08.
//

// MARK: Let's implement Webservice Client!

import Foundation
import Combine
import RxSwift
import RxCocoa

enum NetworkError: Error {
  /// couldn't decode the data
  case decodingError
  case domainError
  case urlError
}

enum HttpMethod: String {
  case get = "GET"
  case post = "POST"
}

struct Resource<T: Codable> {
  let url: URL
  var httpMethod: HttpMethod = .get
  var body: Data? = nil
}

extension Resource {
  init(url: URL) {
    self.url = url
  }
}

class Webservice {
  /// RxSwift Observable, RxCocoa Wrapper function을 활용한 비동기 API 처리
  func loadWithRx<T>(resource: Resource<T>) -> Observable<T> {
    var request = URLRequest(url: resource.url)
    request.httpBody = resource.body
    request.httpMethod = resource.httpMethod.rawValue
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    return Observable.just(request)
      .flatMap { request in
        URLSession.shared.rx.data(request: request)
      }
      .decode(type: T.self, decoder: JSONDecoder())
      .observe(on: MainScheduler.instance)
      .asObservable()
  }
  
  /// Combine Publisher를 활용한 비동기 API 처리
  func loadWithCombine<T>(resource: Resource<T>) -> AnyPublisher<T, Never> {
    var request = URLRequest(url: resource.url)
    request.httpMethod = resource.httpMethod.rawValue
    request.httpBody = resource.body
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    return URLSession.shared.dataTaskPublisher(for: request)
      .map(\.data)
      .decode(type: T.self, decoder: JSONDecoder())
      .catch { _ in
        return Empty<T, Never>()
      }
      .receive(on: RunLoop.main)
      .eraseToAnyPublisher()
  }
  
  func load<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkError>) -> Void) {
    
    var request = URLRequest(url: resource.url)
    request.httpMethod = resource.httpMethod.rawValue
    request.httpBody = resource.body
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data, error == nil else {
        completion(.failure(.domainError))
        return
      }
      
      guard let result = try? JSONDecoder().decode(T.self, from: data) else {
        completion(.failure(.decodingError))
        return
      }
      
      DispatchQueue.main.async {
        completion(.success(result))
      }
    }
    .resume()
  }
}
