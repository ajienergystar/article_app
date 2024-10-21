//
//  AppDependencyInjector.swift
//  ArticleApp
//
//  Created by mac on 21/10/24.
//

import SwiftUI

struct AppDependencyInjector {
    @MainActor static func articleInject() -> ArticlesViewModel {
        let repository = ModulesRepository()
        let useCase = FetchArticlesUseCase(repository: repository)
        return ArticlesViewModel(fetchArticlesUseCase: useCase)
    }
    
    @MainActor static func blogInject() -> BlogsViewModel {
        let repository = ModulesRepository()
        let useCase = FetchBlogsUseCase(repository: repository)
        return BlogsViewModel(fetchBlogsUseCase: useCase)
    }
    
    @MainActor static func reportInject() -> ReportsViewModel {
        let repository = ModulesRepository()
        let useCase = FetchReportsUseCase(repository: repository)
        return ReportsViewModel(fetchReportsUseCase: useCase)
    }
}


