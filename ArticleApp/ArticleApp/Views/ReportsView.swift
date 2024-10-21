//
//  ReportsView.swift
//  ArticleApp
//
//  Created by mac on 21/10/24.
//

import SwiftUI

struct ReportsView: View {
    @StateObject private var viewModel = ReportsViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.reports) { report in
                VStack(alignment: .leading) {
                    AsyncImage(url: URL(string: report.imageUrl)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 200)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Text(report.title)
                        .font(.headline)
                        .padding(.top, 8)
                    
                    Text(report.summary)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(3)
                    
                    HStack {
                        Text("Published at: \(formattedDate(report.publishedAt))")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        Link("Read more", destination: URL(string: report.url)!)
                    }
                }
                .padding()
            }
            .navigationTitle("Spaceflight Reports")
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
