//
//  ReportsUseCaseLayer.swift
//  ArticleApp
//
//  Created by mac on 21/10/24.
//

import Foundation

protocol FetchReportsUseCaseProtocol {
    func execute(limit: Int, offset: Int) async throws -> [Report]
}

class FetchReportsUseCase: FetchReportsUseCaseProtocol {
    private let repository: ModulesRepositoryProtocol

    init(repository: ModulesRepositoryProtocol) {
        self.repository = repository
    }

    func execute(limit: Int, offset: Int) async throws -> [Report] {
        return try await repository.fetchReports(limit: limit, offset: offset)
    }
}
