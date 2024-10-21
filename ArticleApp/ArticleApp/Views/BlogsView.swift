//
//  BlogsView.swift
//  ArticleApp
//
//  Created by mac on 21/10/24.
//

import SwiftUI

struct BlogsView: View {
    @StateObject private var viewModel = BlogsViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.blogs) { blog in
                VStack(alignment: .leading) {
                    AsyncImage(url: URL(string: blog.imageUrl)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 200)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Text(blog.title)
                        .font(.headline)
                        .padding(.top, 8)
                    
                    Text(blog.summary)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(3)
                    
                    HStack {
                        Text("Published at: \(formattedDate(blog.publishedAt))")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        Link("Read more", destination: URL(string: blog.url)!)
                    }
                }
                .padding()
            }
            .navigationTitle("Spaceflight Blogs")
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
