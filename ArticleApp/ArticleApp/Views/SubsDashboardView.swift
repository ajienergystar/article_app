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
    @StateObject var viewModel: ArticlesViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Article")
                Spacer()
                NavigationLink(destination: ArticlesView(viewModel: AppDependencyInjector.articleInject())) {
                    Text("see more")
                }
            }
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(viewModel.articles) { article in
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
                viewModel.fetchArticles()
            }
        }
    }
}

// Similar views for BlogView and ReportView
struct BlogView: View {
    @StateObject var viewModel: BlogsViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Blog")
                Spacer()
                NavigationLink(destination: BlogsView(viewModel: AppDependencyInjector.blogInject())) {
                    Text("see more")
                }
            }
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(viewModel.blogs) { blog in
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
                viewModel.fetchBlogs()
            }
        }
    }
}

struct ReportView: View {
    @StateObject var viewModel: ReportsViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Report")
                Spacer()
                NavigationLink(destination: ReportsView(viewModel: AppDependencyInjector.reportInject())) {
                    Text("see more")
                }
            }
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(viewModel.reports) { report in
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
                Task {
                    viewModel.fetchReports()
                }
            }
        }
    }
}

