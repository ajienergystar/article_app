//
//  ArticlesView.swift
//  ArticleApp
//
//  Created by mac on 21/10/24.
//

import SwiftUI

struct ArticlesView: View {
    @StateObject private var viewModel = ArticlesViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.articles) { article in
                VStack(alignment: .leading) {
                    AsyncImage(url: URL(string: article.imageUrl)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 200)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Text(article.title)
                        .font(.headline)
                        .padding(.top, 8)
                    
                    Text(article.summary)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(3)
                    
                    HStack {
                        Text("Published at: \(formattedDate(article.publishedAt))")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        Link("Read more", destination: URL(string: article.url)!)
                    }
                }
                .padding()
            }
            .navigationTitle("Article News")
        }
    }
    
    private func formattedDate(_ isoDate: String) -> String {
        let dateFormatter = ISO8601DateFormatter()
        if let date = dateFormatter.date(from: isoDate) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .medium
            return displayFormatter.string(from: date)
        }
        return isoDate
    }
}
