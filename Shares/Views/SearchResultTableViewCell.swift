//
//  SearchResultTableViewCell.swift
//  Shares
//
//  Created by Сергей Анпилогов on 26.10.2023.
//

import UIKit
import SnapKit

class SearchResultTableViewCell: UITableViewCell {
    
    
    static let identifier = "SearchResultTableViewCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    
    var model: SearchResult? {
        didSet {
            guard let model = model else {return}
            self.titleLabel.text =  model.displaySymbol
            self.subTitleLabel.text = model.description
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupContraints()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupView() {
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        subTitleLabel.font = .systemFont(ofSize: 10, weight: .medium)
        
    
        addSubview(titleLabel)
        addSubview(subTitleLabel)
    }
}
extension SearchResultTableViewCell  {
    private func setupContraints() {
        titleLabel.snp.makeConstraints({
            $0.leading.equalToSuperview().inset(10)
            $0.top.equalToSuperview().inset(5)
        })
        subTitleLabel.snp.makeConstraints({
            $0.leading.equalToSuperview().inset(10)
            $0.top.equalTo(titleLabel.snp.bottom)
        })
    }
}
