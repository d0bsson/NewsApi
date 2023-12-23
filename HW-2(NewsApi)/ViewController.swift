//
//  ViewController.swift
//  HW-2(NewsApi)
//
//  Created by d0bsson on 23.12.2023.
//

import UIKit

class ViewController: UIViewController {
    let service = Service()
    
    lazy var table: UITableView = {
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        $0.dataSource = self
        return $0
    }(UITableView(frame: view.frame, style: .insetGrouped))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(table)
        service.getNews(q: "sega", count: 10)
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = String(indexPath.debugDescription)
        return cell
    }
    
    
}

