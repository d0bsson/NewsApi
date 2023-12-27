//
//  NetworkManager.swift
//  HW-2(NewsApi)
//
//  Created by d0bsson on 27.12.2023.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func getNews(q: String, count: Int, with complition: @escaping ([Articles]) -> Void) {
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
        
        guard let url = urlComponents.url else { return }
        let request = URLRequest(url: url)
        print(url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }
            
            do {
                let news = try JSONDecoder().decode(News.self, from: data)
                DispatchQueue.main.async {
                    complition(news.articles)
                }
            } catch let error {
                print(error.localizedDescription)

            }
            
        }.resume()
    }
}
