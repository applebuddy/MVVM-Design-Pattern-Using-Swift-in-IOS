//
//  StockListViewModel.swift
//  StocksAppSwiftUI
//
//  Created by MinKyeongTae on 2022/10/09.
//

// MARK: 60. Fetching Stocks and Populatiing View Models
// viewModel을 ObservableObject로 선언하여 @Published 값이 변경될 때마다 publisher 이벤트를 통해 UI를 업데이트시킬 수 있다.

import Foundation
import RxSwift
import RxCocoa
import Combine

class StockListViewModel: ObservableObject {
  
  @Published var searchTerm: String = ""
  // 프로퍼티 래퍼, @Published로 지정된 값은 변경이 될때마다 뷰를 업데이트할때 사용한다.
  @Published var stocks: [StockViewModel] = []
  @Published var news: [NewsArticleViewModel] = []
  private let disposeBag = DisposeBag()
  private var cancellables = Set<AnyCancellable>()
  
  func load() {
    fetchNews()
    fetchStocks()
  }
  
  private func fetchNews() {
    Webservice().getTopNews { [weak self] articles in
      guard let articles = articles else {
        return
      }
      self?.news = articles.map(NewsArticleViewModel.init)
    }
  }
  
  /// ViewModel에서 Webservice를 통해 API 요청을 한다.
  private func fetchStocks() {
    // Combine을 사용한 API 호출
    Webservice().getStocksWithCombine()
      .map { stocks in
        stocks.map(StockViewModel.init)
      }
      .sink { error in
        print(error) // 에러가 발생 시 호출
      } receiveValue: { [weak self] stocks in
        self?.stocks = stocks // 데이터 정상 수신 및 디코딩 시 호출
      }
      .store(in: &cancellables)

    
    // RxSwift, RxCocoa를 사용한 API 호출
    /*
    Webservice().getStocksWithRxSwift()
      .map { stocks in
        stocks.map(StockViewModel.init)
      }
      .subscribe(onNext: { [weak self] stocks in
        self?.stocks = stocks
      })
      .disposed(by: disposeBag)
     */
    
    // async await 방식으로 API 호출
    /*
    Task {
      do {
        let stocks = try await Webservice().getStocksWithAsyncAwait()
        DispatchQueue.main.async {
          self.stocks = stocks?.compactMap { $0 }.map(StockViewModel.init) ?? []
        }
      } catch let error {
        debugPrint(error.localizedDescription)
      }
    }
    */
     
    /*
    Webservice().getStocks { [weak self] stocks in
      guard let stocks = stocks else {
        return
      }
      DispatchQueue.main.async {
        self?.stocks = stocks.map(StockViewModel.init)
      }
    }
     */
  }
}
