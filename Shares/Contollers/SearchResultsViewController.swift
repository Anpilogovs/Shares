//
//  SearchResultsViewController.swift
//  Shares
//
//  Created by Сергей Анпилогов on 26.10.2023.
//

import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject {
    func searchResultsViewControllerDidSelect(searchResult: String)
}

class SearchResultsViewController: UIViewController {
    
    weak var delegate: SearchResultsViewControllerDelegate?
    
    private var results: [String] = []

    private let tableView: UITableView = {
        let table = UITableView()
        table.register(SearchResultTableViewCell.self, forCellReuseIdentifier: SearchResultTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTable()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func setupTable() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func update(with results: [String]) {
        self.results = results
        tableView.reloadData()
    }
}

extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.identifier, for: indexPath)
        
        cell.textLabel?.text = "AAPL"
        cell.detailTextLabel?.text = "Apple Inc"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.searchResultsViewControllerDidSelect(searchResult: "AAPL")
    }
}
