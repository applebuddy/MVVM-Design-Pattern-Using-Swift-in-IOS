//
//  URLRequest+Extension.swift
//  NewsApp
//
//  Created by MinKyeongTae on 2022/10/04.
//

import Foundation
import RxSwift
import RxCocoa

struct Resource<T: Decodable> {
  let url: URL
}

extension URLRequest {

  static func loadWithRx<T>(resource: Resource<T>) -> Observable<T> {
    let url = resource.url
    return Observable.just(url)
      .flatMap { url -> Observable<Data> in
        let urlRequest = URLRequest(url: url)
        return URLSession.shared.rx.data(request: urlRequest)
      }
      .decode(type: T.self, decoder: JSONDecoder())
      .observe(on: MainScheduler.instance)
      .asObservable()
  }
}
