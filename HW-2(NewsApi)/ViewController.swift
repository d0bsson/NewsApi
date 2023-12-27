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
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        $0.dataSource = self
        return $0
    }(UITableView(frame: view.frame, style: .insetGrouped))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(table)
        NetworkManager.shared.getNews(q: "Russia", count: 10) { articles in
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
        articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = articles[indexPath.row].title
        return cell
    }
    
    
}

