//
//  ReportResponse.swift
//  ArticleApp
//
//  Created by mac on 21/10/24.
//

import Foundation

// MARK: - Report Model
struct ReportResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Report]
}

struct Report: Codable, Identifiable {
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
