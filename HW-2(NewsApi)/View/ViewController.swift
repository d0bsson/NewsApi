//
//  ViewController.swift
//  HW-2(NewsApi)
//
//  Created by d0bsson on 23.12.2023.
//

import UIKit

class ViewController: UIViewController {
    private var articles: [Articles] = []
    
    lazy var table: UITableView = {
        $0.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.reuseId)
        $0.dataSource = self
//        $0.delegate = self
        return $0
    }(UITableView(frame: view.frame, style: .insetGrouped))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(table)
        NetworkManager.shared.getNews(q: "russia", count: 10) { articles in
            self.articles = articles
            print(articles)
            
            DispatchQueue.main.async {
                self.table.reloadData()
                }
            }
        }
    }

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomTableViewCell {
            cell.configureCell(data: articles[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}



