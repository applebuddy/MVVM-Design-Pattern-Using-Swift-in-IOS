//
//  ContentView.swift
//  StocksAppSwiftUI
//
//  Created by MinKyeongTae on 2022/10/09.
//

import SwiftUI

struct ContentView: View {
  @ObservedObject private var stockListViewModel = StockListViewModel()
  
  init() {
    UINavigationBar.appearance().backgroundColor = .black
    UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    UITableView.appearance().backgroundColor = .black
    UITableViewCell.appearance().backgroundColor = .black
    // ViewModel에서 API 요청 후 응답 데이터가 @ObservableObject > @Published 변수에 할당되어 변경이 되면
    // -> @ObservedObject 객체 데이터에 맞게 SwiftUI View도 업데이트 된다.
    stockListViewModel.load()
  }
  
  var body: some View {
    
    let filteredStocks = self.stockListViewModel.searchTerm.isEmpty ? self.stockListViewModel.stocks : self.stockListViewModel.stocks.filter { $0.symbol.starts(with: self.stockListViewModel.searchTerm) }
    NavigationView {
      ZStack(alignment: .leading) {
        
        Color.black
        
        Text("January 5 2020")
          .font(.custom("Arial", size: 32))
          .fontWeight(.bold)
          .foregroundColor(Color.gray)
          .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
          .offset(y: -400)
        
        // SearchView의 @Binding 변수에 바인딩 변수 전달을 위해 @State 변수 이름 앞에 '$'를 붙여 전달한다.
        SearchView(searchTerm: $stockListViewModel.searchTerm)
          .offset(y: -250)
        
        StockListView(stocks: filteredStocks)
          .offset(y: 200)
        
        NewsArticleView(newsArticles: self.stockListViewModel.news)
          .offset(y: 500)
      }
      .navigationBarTitle("Stocks")
      .background(Color.black.ignoresSafeArea())
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
