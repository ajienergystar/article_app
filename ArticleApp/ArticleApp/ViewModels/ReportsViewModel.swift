//
//  ReportsViewModel.swift
//  ArticleApp
//
//  Created by mac on 21/10/24.
//

import Foundation

@MainActor
class ReportsViewModel: ObservableObject {
    @Published var reports: [Report] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let fetchReportsUseCase: FetchReportsUseCaseProtocol

    init(fetchReportsUseCase: FetchReportsUseCaseProtocol) {
        self.fetchReportsUseCase = fetchReportsUseCase
    }

    func fetchReports(limit: Int = 10, offset: Int = 10) {
        isLoading = true
        Task {
            do {
                let fetchedReports = try await fetchReportsUseCase.execute(limit: limit, offset: offset)
                reports = fetchedReports
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
}
