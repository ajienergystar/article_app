//
//  Services.swift
//  ArticleApp
//
//  Created by mac on 21/10/24.
//

import Foundation

protocol ServicesProtocol {
    func fetchReports(limit: Int, offset: Int) async throws -> ReportsResponse
}

class Services: ServicesProtocol {
    
    func fetchReports(limit: Int, offset: Int) async throws -> ReportsResponse {
        guard let url = URL(string: "\(APIEndPoint.baseUrl)v4/reports/?limit=\(limit)&offset=\(offset)") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let reportsResponse = try JSONDecoder().decode(ReportsResponse.self, from: data)
        return reportsResponse
    }
    
    func fetchArticles(limit: Int, offset: Int) async throws -> [Article] {
        guard let url = URL(string: "\(APIEndPoint.baseUrl)v4/articles/?limit=\(limit)&offset=\(offset)") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(ArticlesResponse.self, from: data)
        return response.results
    }
}
