//
//  ArticlesViewModel.swift
//  ArticleApp
//
//  Created by mac on 21/10/24.
//

import Foundation

@MainActor
class ArticlesViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let fetchArticlesUseCase: FetchArticlesUseCaseProtocol

    init(fetchArticlesUseCase: FetchArticlesUseCaseProtocol) {
        self.fetchArticlesUseCase = fetchArticlesUseCase
    }

    func fetchArticles(limit: Int = 10, offset: Int = 10) {
        isLoading = true
        Task {
            do {
                let fetchedArticles = try await fetchArticlesUseCase.execute(limit: limit, offset: offset)
                articles = fetchedArticles
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
}
