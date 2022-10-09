//
//  StockListViewModel.swift
//  StocksAppSwiftUI
//
//  Created by MinKyeongTae on 2022/10/09.
//

// MARK: 60. Fetching Stocks and Populatiing View Models
// viewModel을 ObservableObject로 선언하여 @Published 값이 변경될 때마다 publisher 이벤트를 통해 UI를 업데이트시킬 수 있다.

import Foundation

class StockListViewModel: ObservableObject {
  
  @Published var searchTerm: String = ""
  // 프로퍼티 래퍼, @Published로 지정된 값은 변경이 될때마다 뷰를 업데이트할때 사용한다.
  @Published var stocks: [StockViewModel] = []
  @Published var news: [NewsArticleViewModel] = []
  
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
    Webservice().getStocks { [weak self] stocks in
      guard let stocks = stocks else {
        return
      }
      DispatchQueue.main.async {
        self?.stocks = stocks.map(StockViewModel.init)
      }
    }
  }
}
