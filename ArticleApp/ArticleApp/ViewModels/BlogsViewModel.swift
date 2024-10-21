//
//  BlogsViewModel.swift
//  ArticleApp
//
//  Created by mac on 21/10/24.
//

import Foundation

@MainActor
class BlogsViewModel: ObservableObject {
    @Published var blogs: [Blog] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let fetchBlogsUseCase: FetchBlogsUseCaseProtocol

    init(fetchBlogsUseCase: FetchBlogsUseCaseProtocol) {
        self.fetchBlogsUseCase = fetchBlogsUseCase
    }

    func fetchBlogs(limit: Int = 10, offset: Int = 10) {
        isLoading = true
        Task {
            do {
                let fetchedBlogs = try await fetchBlogsUseCase.execute(limit: limit, offset: offset)
                blogs = fetchedBlogs
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
}
