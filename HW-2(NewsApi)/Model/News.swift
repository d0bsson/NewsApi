//
//  News.swift
//  HW-2(NewsApi)
//
//  Created by d0bsson on 23.12.2023.
//

import Foundation

struct News: Codable {
    let totalResults: Int?
    let articles: [Articles]
}

struct Articles: Codable {
    let source: Source
    let author: String?
    let title: String?
    let urlToImage: String?
    let description: String?
}

struct Source: Codable {
    let id: String?
    let name: String?
}
