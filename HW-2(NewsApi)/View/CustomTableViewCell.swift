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
        
        if let stringUrl = data.urlToImage,
           let imageUrl = URL(string: stringUrl){
            self.image.loadImage(url: imageUrl, AI: activityIndicator)
        }
        
        let hAnchor = image.heightAnchor.constraint(equalToConstant: 200)
        hAnchor.priority = .defaultHigh
        hAnchor.isActive = true
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            cellView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            hAnchor,
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
}

extension UIImageView{
    func loadImage(url: URL, AI: UIActivityIndicatorView) {
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
                AI.stopAnimating()
            }
        }
    }
}
