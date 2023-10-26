//
//  ViewController.swift
//  Shares
//
//  Created by Сергей Анпилогов on 26.10.2023.
//

import UIKit

class WatchListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTitleView()
        setupSearchController()
    }
    
    
    private func setupTitleView() {
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: navigationController?.navigationBar.height ?? 100))
        
        titleView.backgroundColor = .link
        
        let label = UILabel(frame: CGRect(x: 10, y: 0, width: titleView.width-20, height: titleView.height))
        label.text = "Shares"
        label.font = .systemFont(ofSize: 32, weight: .medium)
        titleView.addSubview(label)
        navigationItem.titleView = titleView
    }
    
    private func setupSearchController() {
        let resultVC = SearchResultsViewController()
        resultVC.delegate = self
        let searchVC = UISearchController(searchResultsController: resultVC)
        searchVC.searchResultsUpdater = self
        navigationItem.searchController = searchVC
    }
}
extension WatchListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
              let results = searchController.searchResultsController as? SearchResultsViewController,
                !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        //Optimize to reduce number of searches for when user stops typing
        
        //Call API to search
        
        //Update result controller
        results.update(with: ["GOOG"])
        print(query)
    }
}

extension WatchListViewController: SearchResultsViewControllerDelegate {
    func searchResultsViewControllerDidSelect(searchResult: String) {
        //Present stock details for given selection
    }
}
