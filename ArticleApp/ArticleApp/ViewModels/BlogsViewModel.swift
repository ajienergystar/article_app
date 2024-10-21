//
//  BlogsViewModel.swift
//  ArticleApp
//
//  Created by mac on 21/10/24.
//

import Foundation
import Combine

class BlogsViewModel: ObservableObject {
    @Published var blogs: [Blog] = []
    private var cancellables = Set<AnyCancellable>()
    private let url = "https://api.spaceflightnewsapi.net/v4/blogs/?limit=6&offset=6"
    
    init() {
        fetchBlogs()
    }
    
    func fetchBlogs() {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: BlogResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching blogs: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                self?.blogs = response.results
            })
            .store(in: &cancellables)
    }
}
