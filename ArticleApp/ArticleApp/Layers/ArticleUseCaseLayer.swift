//
//  ArticleUseCaseLayer.swift
//  ArticleApp
//
//  Created by mac on 21/10/24.
//

import Foundation

protocol FetchArticlesUseCaseProtocol {
    func execute(limit: Int, offset: Int) async throws -> [Article]
}

class FetchArticlesUseCase: FetchArticlesUseCaseProtocol {
    private let repository: ModulesRepositoryProtocol

    init(repository: ModulesRepositoryProtocol) {
        self.repository = repository
    }

    func execute(limit: Int, offset: Int) async throws -> [Article] {
        return try await repository.fetchArticles(limit: limit, offset: offset)
    }
}
