//
//  ReportsView.swift
//  ArticleApp
//
//  Created by mac on 21/10/24.
//

import SwiftUI

struct ReportsView: View {
    @StateObject var viewModel: ReportsViewModel
    @State private var searchText: String = "" // Search text state

    var body: some View {
        NavigationView {
            VStack {
                // Search text field
                TextField("Search reports...", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                if viewModel.isLoading {
                    ProgressView("Loading reports...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                } else {
                    // Filter reports based on search text
                    List(filteredReports) { report in
                        NavigationLink(destination: ReportDetailView(report: report)) {
                            ReportRowView(report: report)
                        }
                    }
                    .navigationTitle("Reports")
                }
            }
            .onAppear {
                viewModel.fetchReports()
            }
        }
    }

    // Filter the reports based on the search text
    var filteredReports: [Report] {
        if searchText.isEmpty {
            return viewModel.reports
        } else {
            return viewModel.reports.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

struct ReportRowView: View {
    let report: Report

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: report.imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
            } placeholder: {
                ProgressView()
            }

            VStack(alignment: .leading) {
                Text(report.title)
                    .font(.headline)
                Text(report.summary)
                    .font(.subheadline)
                    .lineLimit(3)
                    .padding(.top, 4)
            }
        }
    }
}

struct ReportDetailView: View {
    let report: Report

    var body: some View {
        VStack(alignment: .leading) {
            Text(report.title)
                .font(.title)
                .padding(.bottom, 8)

            AsyncImage(url: URL(string: report.imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            Text(report.summary)
                .padding(.top, 8)

            Link("Read more", destination: URL(string: report.url)!)
                .padding(.top, 8)
                .foregroundColor(.blue)

            Spacer()
        }
        .padding()
        .navigationTitle(report.title)
    }
}
