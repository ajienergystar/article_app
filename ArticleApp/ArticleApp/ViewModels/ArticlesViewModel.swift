//
//  ArticlesViewModel.swift
//  ArticleApp
//
//  Created by mac on 21/10/24.
//

import Foundation
import Combine

class ArticlesViewModel: ObservableObject {
    @Published var articles: [Article] = []
    private var cancellables = Set<AnyCancellable>()
    private let url = "https://api.spaceflightnewsapi.net/v4/articles/?limit=6&offset=6"
    
    init() {
        fetchArticles()
    }
    
    func fetchArticles() {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: ArticleResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching articles: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                self?.articles = response.results
            })
            .store(in: &cancellables)
    }
}
