//
//  BlogsUseCaseLayer.swift
//  ArticleApp
//
//  Created by mac on 21/10/24.
//

import Foundation

protocol FetchBlogsUseCaseProtocol {
    func execute(limit: Int, offset: Int) async throws -> [Blog]
}

class FetchBlogsUseCase: FetchBlogsUseCaseProtocol {
    private let repository: ModulesRepositoryProtocol

    init(repository: ModulesRepositoryProtocol) {
        self.repository = repository
    }

    func execute(limit: Int, offset: Int) async throws -> [Blog] {
        return try await repository.fetchBlogs(limit: limit, offset: offset)
    }
}
