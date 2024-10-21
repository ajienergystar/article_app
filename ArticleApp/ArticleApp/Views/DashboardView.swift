//
//  DashboardView.swift
//  ArticleApp
//
//  Created by mac on 21/10/24.
//

import SwiftUI

struct DashboardView: View {
    @StateObject private var viewModel = ArticlesViewModel()

        var body: some View {
            NavigationView {
                List(viewModel.articles) { article in
                    VStack(alignment: .leading, spacing: 10) {
                        Text(article.title)
                            .font(.headline)
                        AsyncImage(url: URL(string: article.imageUrl)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity, maxHeight: 200)
                        } placeholder: {
                            ProgressView()
                        }
                        Text(article.summary)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 10)
                }
                .navigationTitle("Spaceflight News")
                .onAppear {
                    viewModel.fetchArticles()
                }
            }
        }
}

#Preview {
    DashboardView()
}
