//
//  ReportResponse.swift
//  ArticleApp
//
//  Created by mac on 21/10/24.
//

import Foundation

struct Report: Identifiable, Codable {
    let id: Int
    let title: String
    let url: String
    let imageUrl: String
    let newsSite: String
    let summary: String
    let publishedAt: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, title, url, summary, newsSite = "news_site", imageUrl = "image_url", publishedAt = "published_at", updatedAt = "updated_at"
    }
}

struct ReportsResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Report]
}
