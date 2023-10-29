//
//  WatchListTableViewCell.swift
//  Shares
//
//  Created by Сергей Анпилогов on 28.10.2023.
//

import UIKit

class WatchListTableViewCell: UITableViewCell {
 static let identifier = "WatchListTableViewCell"
    
    
    struct ViewModel {
        let symbol: String
        let companyName: String
        let price: String // formatted
        let chageColor: UIColor //red or green
        let chagePercentage: String // formatted
        // let chartViewModel: CharesView.ViewModel
        
        
        
    }
    
    //Symbol Label
    private let symbolLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    //Company Label
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    //MiniChart View
    
    //Price Label
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    //Change in Price Label
    private let changePriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private let miniCharView = CharesChartView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(symbolLabel)
        addSubview(nameLabel)
        addSubview(priceLabel)
        addSubview(changePriceLabel)
        addSubview(miniCharView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        symbolLabel.text = nil
        nameLabel.text = nil
        priceLabel.text = nil
        changePriceLabel.text = nil
        miniCharView.reset()
    }
    
    
    public func configure(wtih viewModel: ViewModel) {
        symbolLabel.text = viewModel.symbol
        nameLabel.text = viewModel.companyName
        priceLabel.text = viewModel.price
        changePriceLabel.text = viewModel.chagePercentage
        changePriceLabel.backgroundColor = viewModel.chageColor
        
        //Configure chart
    }
    
}
