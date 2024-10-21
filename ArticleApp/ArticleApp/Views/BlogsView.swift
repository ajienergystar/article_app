//
//  BlogsView.swift
//  ArticleApp
//
//  Created by mac on 21/10/24.
//

import SwiftUI

struct BlogsView: View {
    @StateObject var viewModel: BlogsViewModel

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading blogs...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                } else {
                    List(viewModel.blogs) { blog in
                        NavigationLink(destination: BlogDetailView(blog: blog)) {
                            BlogRowView(blog: blog)
                        }
                    }
                    .navigationTitle("Blogs")
                }
            }
            .onAppear {
                viewModel.fetchBlogs()
            }
        }
    }
}

struct BlogRowView: View {
    let blog: Blog

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: blog.imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
            } placeholder: {
                ProgressView()
            }

            VStack(alignment: .leading) {
                Text(blog.title)
                    .font(.headline)
                Text(blog.summary)
                    .font(.subheadline)
                    .lineLimit(3)
                    .padding(.top, 4)
            }
        }
    }
}

struct BlogDetailView: View {
    let blog: Blog

    var body: some View {
        VStack(alignment: .leading) {
            Text(blog.title)
                .font(.title)
                .padding(.bottom, 8)

            AsyncImage(url: URL(string: blog.imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            Text(blog.summary)
                .padding(.top, 8)

            Link("Read more", destination: URL(string: blog.url)!)
                .padding(.top, 8)
                .foregroundColor(.blue)

            Spacer()
        }
        .padding()
        .navigationTitle(blog.title)
    }
}
