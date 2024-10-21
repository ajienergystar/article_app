//
//  ArticlesView.swift
//  ArticleApp
//
//  Created by mac on 21/10/24.
//

import SwiftUI

struct ArticlesView: View {
    @StateObject var viewModel: ArticlesViewModel

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading articles...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                } else {
                    List(viewModel.articles) { article in
                        NavigationLink(destination: ArticleDetailView(article: article)) {
                            ArticleRowView(article: article)
                        }
                    }
                    .navigationTitle("Articles")
                }
            }
            .onAppear {
                viewModel.fetchArticles()
            }
        }
    }
}

struct ArticleRowView: View {
    let article: Article

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: article.imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
            } placeholder: {
                ProgressView()
            }

            VStack(alignment: .leading) {
                Text(article.title)
                    .font(.headline)
                Text(article.summary)
                    .font(.subheadline)
                    .lineLimit(3)
                    .padding(.top, 4)
            }
        }
    }
}

struct ArticleDetailView: View {
    let article: Article

    var body: some View {
        VStack(alignment: .leading) {
            Text(article.title)
                .font(.title)
                .padding(.bottom, 8)

            AsyncImage(url: URL(string: article.imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            Text(article.summary)
                .padding(.top, 8)

            Link("Read more", destination: URL(string: article.url)!)
                .padding(.top, 8)
                .foregroundColor(.blue)

            Spacer()
        }
        .padding()
        .navigationTitle(article.title)
    }
}
