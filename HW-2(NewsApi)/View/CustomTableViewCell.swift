//
//  CustomTableViewCell.swift
//  HW-2(NewsApi)
//
//  Created by d0bsson on 27.12.2023.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    static let reuseId = "cell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        $0.startAnimating()
        $0.hidesWhenStopped = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIActivityIndicatorView())
    
    private lazy var cellView: UIView = {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 15
        
        $0.addSubview(image)
        $0.addSubview(titleLabel)
        $0.addSubview(activityIndicator)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private lazy var image: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private lazy var titleLabel: UILabel = {
        $0.numberOfLines = 0
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.textColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    func configureCell(data: Articles) {
        self.addSubview(cellView)
        titleLabel.text = data.title
        
        if let stringUrl = data.urlToImage {
            loadImage(from: stringUrl)
        }
           
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            cellView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            image.topAnchor.constraint(equalTo: cellView.topAnchor),
            image.leadingAnchor.constraint(equalTo: cellView.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: cellView.trailingAnchor),
            image.bottomAnchor.constraint(equalTo: cellView.bottomAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -18),
            titleLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 20),
            
            activityIndicator.centerXAnchor.constraint(equalTo: cellView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: cellView.centerYAnchor)
            
        ])
    }
    
    private func loadImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        self.activityIndicator.stopAnimating()
        if let cachedImage = getCachedImage(from: imageURL) {
            self.image.image = cachedImage
            return
        }
        ImageManager.shared.loadImage(url: imageURL) { data, response in
            self.image.image = UIImage(data: data)
            self.saveDataToCache(with: data, and: response)
            self.activityIndicator.stopAnimating()
        }
    }
    
    private func saveDataToCache(with data: Data, and response: URLResponse) {
        guard let url = response.url else { return }
        let request = URLRequest(url: url)
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: request)
    }
    
    private func getCachedImage(from url: URL) -> UIImage? {
        let request = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            return UIImage(data: cachedResponse.data)
        }
        return nil
    }
}

