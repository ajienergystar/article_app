//
//  ArticleResponse.swift
//  ArticleApp
//
//  Created by mac on 21/10/24.
//

import Foundation

// MARK: - Article Model
struct ArticleResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Article]
}

struct Article: Codable, Identifiable {
    let id: Int
    let title: String
    let url: String
    let imageUrl: String
    let newsSite: String
    let summary: String
    let publishedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, url, summary, newsSite = "news_site", imageUrl = "image_url", publishedAt = "published_at"
    }
}
