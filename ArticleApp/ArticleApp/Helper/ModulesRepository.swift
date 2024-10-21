//
//  ArticlesRepository.swift
//  ArticleApp
//
//  Created by mac on 21/10/24.
//

import Foundation

protocol ModulesRepositoryProtocol {
    func fetchArticles(limit: Int, offset: Int) async throws -> [Article]
    func fetchBlogs(limit: Int, offset: Int) async throws -> [Blog]
    func fetchReports(limit: Int, offset: Int) async throws -> [Report]
}

class ModulesRepository: ModulesRepositoryProtocol {
    
    func fetchArticles(limit: Int, offset: Int) async throws -> [Article] {
        guard let url = URL(string: "\(APIEndPoint.baseUrl)v4/articles/?limit=\(limit)&offset=\(offset)") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(ArticlesResponse.self, from: data)
        return response.results
    }
    
    func fetchBlogs(limit: Int, offset: Int) async throws -> [Blog] {
        guard let url = URL(string: "\(APIEndPoint.baseUrl)v4/blogs?limit=\(limit)&offset=\(offset)") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(BlogsResponse.self, from: data)
        return response.results
    }
    
    func fetchReports(limit: Int, offset: Int) async throws -> [Report] {
        guard let url = URL(string: "\(APIEndPoint.baseUrl)v4/reports?limit=\(limit)&offset=\(offset)") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(ReportsResponse.self, from: data)
        return response.results
    }
}
