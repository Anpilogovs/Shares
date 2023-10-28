//
//  TopStoriesNewsViewController.swift
//  Shares
//
//  Created by Сергей Анпилогов on 26.10.2023.
//

import UIKit

class NewsViewController: UIViewController {
    
    enum `Type` {
        case topStories
        case compan(symbol: String)
        
        var title: String {
            switch self {
            case .topStories:
                return "Top Stories"
            case .compan(symbol: let symbol):
                return symbol.uppercased()
            }
        }
    }
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.register(NewsStoryTableViewCell.self, forCellReuseIdentifier: NewsStoryTableViewCell.identifier)
        table.register(NewsHeaderView.self, forHeaderFooterViewReuseIdentifier: NewsHeaderView.identifier)
        return table
    }()
    
    private let type: Type
    private var stories: [NewsStory] = [
        .init(category: "tech", datetime: 123, headline: "Some headline should go here!", image: "", related: "Realted", source: "CNBC", summary: "", url: "")
    ]

    init(type: Type) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        fetchNews()
        
        view.backgroundColor = .secondarySystemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
   }
    
    private func setupTable() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func fetchNews() {
        
    }
    
    public func open(url: URL) {
        
    }
}
extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsStoryTableViewCell.identifier, for: indexPath) as? NewsStoryTableViewCell else { return UITableViewCell()}
        cell.configure(with: .init(model: stories[indexPath.row]))
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: NewsHeaderView.identifier) as? NewsHeaderView else {
            return nil
        }
        header.configure(with: .init(title: self.type.title, shouldShowAddButton: false))
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return NewsStoryTableViewCell.preferredHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  NewsStoryTableViewCell.preferredHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //Open news story
    }
}
