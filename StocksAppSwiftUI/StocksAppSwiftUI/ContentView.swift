//
//  ContentView.swift
//  StocksAppSwiftUI
//
//  Created by MinKyeongTae on 2022/10/09.
//

import SwiftUI

struct ContentView: View {
  
  @State private var searchTerm: String = ""
  
  init() {
    UINavigationBar.appearance().backgroundColor = .black
    UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    UITableView.appearance().backgroundColor = .black
    UITableViewCell.appearance().backgroundColor = .black
  }
  
  var body: some View {
    NavigationView {
      ZStack(alignment: .leading) {
        Color.black
        VStack(alignment: .leading) {
          Text("January 5 2020")
            .font(.custom("Arial", size: 32))
            .fontWeight(.bold)
            .foregroundColor(Color.gray)
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 0))
          
          // SearchView의 @Binding 변수에 바인딩 변수 전달을 위해 @State 변수 이름 앞에 '$'를 붙여 전달한다.
          SearchView(searchTerm: $searchTerm)
          
          Spacer()
        }
      }
      .navigationBarTitle("Stocks")
    }.edgesIgnoringSafeArea(Edge.Set(.bottom))
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
