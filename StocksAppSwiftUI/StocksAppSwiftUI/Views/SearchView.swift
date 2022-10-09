//
//  SearchView.swift
//  StocksAppSwiftUI
//
//  Created by MinKyeongTae on 2022/10/09.
//

import SwiftUI

struct SearchView: View {
  @Binding var searchTerm: String
  
  var body: some View {
    HStack {
      Image(systemName: "magnifyingglass")
      TextField("Search", text: self.$searchTerm)
      Spacer()
    }
    .frame(height: 30)
    .foregroundColor(.secondary)
    .background(Color(.secondarySystemBackground))
    .cornerRadius(10)
    .padding(10)
  }
}

struct SearchView_Previews: PreviewProvider {
  static var previews: some View {
    SearchView(searchTerm: .constant(""))
  }
}
