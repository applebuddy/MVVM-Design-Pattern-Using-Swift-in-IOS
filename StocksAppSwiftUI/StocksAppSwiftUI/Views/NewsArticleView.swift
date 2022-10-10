//
//  NewsArticleView.swift
//  StocksAppSwiftUI
//
//  Created by MinKyeongTae on 2022/10/10.
//

import SwiftUI

// MARK: 69. Downloading Images Using URLImage Package
import URLImage

struct NewsArticleView: View {
  
  let newsArticles: [NewsArticleViewModel]
  let onDragBegin: (DragGesture.Value) -> Void
  let onDragEnd: (DragGesture.Value) -> Void
  
  var body: some View {
    let screenSize = UIScreen.main.bounds.size
    VStack(alignment: .leading) {
      HStack {
        VStack(alignment: .leading) {
          Text("Top News")
            .foregroundColor(.white)
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(2)
          
          Text("From 👩🏻‍💻News")
            .foregroundColor(.gray)
            .font(.body)
            .fontWeight(.bold)
            .padding(2)
          
          Spacer()
        }
        .frame(height: 100)
        .frame(maxWidth: .infinity, alignment: .leading)
      }
      .padding().contentShape(Rectangle())
      .gesture(DragGesture()
        .onChanged(self.onDragBegin)
        .onEnded(self.onDragEnd)
      )
      
      ScrollView {
        VStack {
          ForEach(self.newsArticles, id: \.title) { article in
            HStack {
              VStack(alignment: .leading) {
                Text(article.publication)
                  .foregroundColor(.white)
                  .font(.custom("Arial", size: 22))
                  .fontWeight(.bold)
                Text(article.title)
                  .font(.custom("Arial", size: 17))
                  .foregroundColor(.gray)
              }
              .padding(.horizontal, 16.0)
              
              Spacer()

              URLImage(
                URL(string: article.imageURL)!,
                content: { $0.resizable()} )
              .frame(width: 100, height: 100)
            }
          }
        }.frame(maxWidth: .infinity)
      }
    }
    .frame(width: screenSize.width, height: screenSize.height)
    .background(Color(red: 22/255, green: 28/255, blue: 30/255))
    .cornerRadius(20)
  }
}

struct NewsArticleView_Previews: PreviewProvider {
  static var previews: some View {
    let article = Article(
      title: "News Title",
      imageURL: "https://prod.static9.net.au/_/media/2019/09/02/10/36/nine_news_melbourne_1600x900_fullstory_nightly6pm.jpg",
      publication: "The WallStreet Journal"
    )
    
    NewsArticleView(
      newsArticles: [NewsArticleViewModel(article: article)],
      onDragBegin: { _ in },
      onDragEnd: { _ in }
    )
  }
}
