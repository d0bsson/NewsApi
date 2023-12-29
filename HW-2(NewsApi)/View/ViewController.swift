//
//  ViewController.swift
//  HW-2(NewsApi)
//
//  Created by d0bsson on 23.12.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private var articles: [Articles] = []
    private let searchController = UISearchController(searchResultsController: nil)
    
    lazy var table: UITableView = {
        $0.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.reuseId)
        $0.dataSource = self
        $0.delegate = self
        return $0
    }(UITableView(frame: view.frame, style: .insetGrouped))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(table)
        setupSearchController()
        
        NetworkManager.shared.getNews(q: "Box", count: 10) { articles in
            self.articles = articles
            print(articles)
            
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }
    }
    private func setupSearchController() {
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.barTintColor = .white
        navigationItem.searchController = searchController
        definesPresentationContext = true
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

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let search = searchBar.text else { return }
        
        NetworkManager.shared.getNews(q: search, count: 10) { articles in
            self.articles = articles
            print(articles)
            
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }
    }
}



