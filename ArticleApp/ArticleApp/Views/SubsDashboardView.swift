//
//  SubsDashboardView.swift
//  ArticleApp
//
//  Created by mac on 21/10/24.
//

import Foundation
import SwiftUI

// MARK: - ArticleView
struct ArticleView: View {
    @ObservedObject var articleViewModels = ArticlesViewModel()

    var body: some View {
        VStack {
            HStack {
                Text("Article")
                Spacer()
                NavigationLink(destination: ArticlesView()) {
                    Text("see more")
                }
            }
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(articleViewModels.articles) { article in
                        VStack {
                            AsyncImage(url: URL(string: article.imageUrl)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(height: 100)
                                    .clipped()
                            } placeholder: {
                                ProgressView()
                            }
                        }.onAppear {
                            print(article.imageUrl)
                        }
                    }
                }
            }.onAppear {
                articleViewModels.fetchArticles()
            }
        }
    }
}

// Similar views for BlogView and ReportView
struct BlogView: View {
    @ObservedObject var blogViewModels = BlogsViewModel()

    var body: some View {
        VStack {
            HStack {
                Text("Blog")
                Spacer()
                NavigationLink(destination: BlogsView()) {
                    Text("see more")
                }
            }
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(blogViewModels.blogs) { blog in
                        VStack {
                            AsyncImage(url: URL(string: blog.imageUrl)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(height: 100)
                                    .clipped()
                            } placeholder: {
                                ProgressView()
                            }
                        }
                    }
                }
            }.onAppear {
                blogViewModels.fetchBlogs()
            }
        }
    }
}

struct ReportView: View {
    @ObservedObject var reportViewModels = ReportsViewModel()

    var body: some View {
        VStack {
            HStack {
                Text("Report")
                Spacer()
                NavigationLink(destination: ReportsView()) {
                    Text("see more")
                }
            }
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(reportViewModels.reports) { report in
                        VStack {
                            AsyncImage(url: URL(string: report.imageUrl)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(height: 100)
                                    .clipped()
                            } placeholder: {
                                ProgressView()
                            }
                        }
                    }
                }
            }.onAppear {
                reportViewModels.fetchReports()
            }
        }
    }
}

