//
//  News.swift
//  HW-2(NewsApi)
//
//  Created by d0bsson on 23.12.2023.
//

import Foundation

class Service {
    func getNews(q: String, count: Int) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "newsapi.org"
        urlComponents.path = "/v2/everything"
        
        urlComponents.queryItems = [
        URLQueryItem(name: "q", value: q),
        URLQueryItem(name: "pageSize", value: "\(count)"),
        URLQueryItem(name: "apiKey", value: "d522f4ce80244e79b06425239a10ce0c"),
        URLQueryItem(name: "language", value: "ru")
        ]
        
        print(urlComponents.url)
        
    }
}

struct News: Codable {
    
}
