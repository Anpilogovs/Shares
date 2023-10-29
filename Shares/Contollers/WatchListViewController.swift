//
//  ViewController.swift
//  Shares
//
//  Created by Сергей Анпилогов on 26.10.2023.
//

import UIKit

class WatchListViewController: UIViewController {
    
    private var searchTime: Timer?
    
    private let tableView: UITableView = {
        let table = UITableView()
        return table
    }()
    
    //Model
    private var watchListMap: [String: [CandleStick]] = [:]
    
    //ViewModels
    private var viewModels: [WatchListTableViewCell.ViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTitleView()
        setupTableView()
        setupWatchListData()
        setupSearchController()
        setUpChild()
    }
    
    private func setUpChild() {
        let vc = NewsViewController(type: .topStories)
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
            sheet.prefersEdgeAttachedInCompactHeight = true
        }
        present(vc, animated: true)

//        addChild(vc)
//        view.addSubview(vc.view)
//        vc.view.frame = CGRect(x: 0, y: view.height/2, width: view.width, height: view.height)
//        vc.didMove(toParent: self)
    }
    
    private func setupWatchListData() {
        let symbols = PersistenceManager.shared.watchlist
        let group = DispatchGroup()
        
        for symbol in symbols {
            group.enter()
            
            APICaller.shared.marketData(for: symbol) {[weak self] results in
                defer {
                    group.leave()
                }
                switch results {
                case .success(let data):
                    let candleStick = data.candleStick
                    self?.watchListMap[symbol] = candleStick
                case .failure(let error):
                    print(error)
                }
            }
        }
        group.notify(queue: .main)  { [weak self] in
            self?.creteViewModels()
            self?.tableView.reloadData()
        }
    }
    
    private func creteViewModels() {
        var viewModels = [WatchListTableViewCell.ViewModel]()
        for (symbol, candleSticks) in watchListMap {
            let chagePrecentage = getChangePercentage(symbol: symbol, data: candleSticks)
            viewModels.append(
                .init(symbol: symbol,
                      companyName: UserDefaults.standard.string(forKey: symbol) ?? "Company",
                      price: getLatesClosingPrice(from: candleSticks),
                      chageColor: chagePrecentage < 0 ? .systemRed : .systemGreen,
                      chagePercentage: String.percentage(from: chagePrecentage)))
        }
        self.viewModels = viewModels
    }
    
    private func getChangePercentage(symbol: String, data: [CandleStick]) -> Double {
        let latesDate = data[0].date
        guard let latesClose = data.first?.close,
              let priorClose = data.first(where: {
                  !Calendar.current.isDate($0.date, inSameDayAs: latesDate)
              })?.close
        else {
            return 0
        }
        let diff = 1 - (priorClose/latesClose)
        return diff
    }
    
    private func getLatesClosingPrice(from data: [CandleStick]) -> String {
        guard let closingPrice = data.first?.close else {
            return ""
        }
        return .formatted(from: closingPrice)
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
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
        
        //Reset timer
        searchTime?.invalidate()
        
        //Kick off new timer 
        
        //Optimize to reduce number of searches for when user stops typing
        searchTime = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { _ in
            //Call API to search
            APICaller.shared.search(query: query) { result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        results.update(with: response.result)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        })
    }
}

extension WatchListViewController: SearchResultsViewControllerDelegate {
    func searchResultsViewControllerDidSelect(searchResult: SearchResult) {
        navigationItem.searchController?.searchBar.resignFirstResponder()
        
        let vc = SharesDetailViewController()
        let navVC = UINavigationController(rootViewController: vc)
        vc.title = searchResult.description
        present(navVC, animated: true)
    }
}
extension WatchListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return watchListMap.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //Open Detailf for Selection
        
    }
}
