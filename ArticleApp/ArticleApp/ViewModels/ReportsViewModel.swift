//
//  ReportsViewModel.swift
//  ArticleApp
//
//  Created by mac on 21/10/24.
//

import Foundation
import Combine

class ReportsViewModel: ObservableObject {
    @Published var reports: [Report] = []
    private var cancellables = Set<AnyCancellable>()
    private let url = "https://api.spaceflightnewsapi.net/v4/reports/?limit=6&offset=6"
    
    init() {
        fetchReports()
    }
    
    func fetchReports() {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: ReportResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching reports: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                self?.reports = response.results
            })
            .store(in: &cancellables)
    }
}
