//
//  CustomTableViewCell.swift
//  HW-2(NewsApi)
//
//  Created by d0bsson on 27.12.2023.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    static let reuseId = "cell"
    
    private lazy var cellView: UIView = {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 15
        
        $0.addSubview(titleLabel)
        $0.addSubview(image)
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
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.textColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    func configureCell(data: Articles) {
        self.addSubview(cellView)
        titleLabel.text = data.title
        
        DispatchQueue.global().async {
            guard let stringUrl = data.urlToImage else { return }
            guard let imageUrl = URL(string: stringUrl) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            DispatchQueue.main.async {
                self.image.image = UIImage(data: imageData)
                
                print("image data is ok")
            }
        }
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            cellView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            image.topAnchor.constraint(equalTo: cellView.topAnchor),
            image.leadingAnchor.constraint(equalTo: cellView.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: cellView.trailingAnchor),
            image.bottomAnchor.constraint(equalTo: cellView.bottomAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: image.leadingAnchor, constant: 50),
            titleLabel.bottomAnchor.constraint(equalTo: image.bottomAnchor, constant: -18),
            titleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
