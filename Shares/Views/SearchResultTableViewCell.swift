//
//  SearchResultTableViewCell.swift
//  Shares
//
//  Created by Сергей Анпилогов on 26.10.2023.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    
    static let identifier = "SearchResultTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    
    required init?(coder: NSCoder) {
        fatalError()
    }

}
