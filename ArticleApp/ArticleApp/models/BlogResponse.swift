//
//  BlogResponse.swift
//  ArticleApp
//
//  Created by mac on 21/10/24.
//

import Foundation

// MARK: - Blog Model
struct BlogResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Blog]
}

struct Blog: Codable, Identifiable {
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
