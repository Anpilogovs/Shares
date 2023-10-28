//
//  NewsStoryTableViewCell.swift
//  Shares
//
//  Created by Сергей Анпилогов on 27.10.2023.
//

import UIKit
import SnapKit

class NewsStoryTableViewCell: UITableViewCell {
    
    static let identifier = "NewsStoryTableViewCell"
    
    static let preferredHeight: CGFloat = 140
    
    struct ViewModel {
        let source: String
        let headline: String
        let dateString: String
        let imageUrl: URL?
        
        init(model: NewsStory) {
            self.source = model.source
            self.headline = model.headline
            self.dateString = .string(from: model.datetime)
            self.imageUrl = URL(string: model.image)
        }
    }
    
    //Source
    private let sourceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    //Headline
    private let headLineLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    //Date
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14, weight: .ultraLight)
        return label
    }()
    //Image
    private let storyImageVIew: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .tertiarySystemBackground
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .secondarySystemBackground
        backgroundColor = .secondarySystemBackground
        addSubview(sourceLabel)
        addSubview(headLineLabel)
        addSubview(dateLabel)
        addSubview(storyImageVIew)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        sourceLabel.text = nil
        headLineLabel.text = nil
        dateLabel.text = nil
        storyImageVIew.image = nil
    }
    
    public func configure(with viewModel: ViewModel) {
        headLineLabel.text = viewModel.headline
        sourceLabel.text = viewModel.source
        dateLabel.text = viewModel.dateString
        
        //Manually set image
//        storyImageVIew.setImage(with: viewModel.imageUrl)
    }
    
    private func setupConstraints() {
        sourceLabel.snp.makeConstraints({
            $0.leading.equalToSuperview().inset(15)
            $0.top.equalToSuperview().inset(5)
        })
        headLineLabel.snp.makeConstraints({
            $0.leading.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(storyImageVIew.snp.leading).inset(5)
        })
        dateLabel.snp.makeConstraints({
            $0.leading.bottom.equalToSuperview().inset(15)
        })
        storyImageVIew.snp.makeConstraints({
            $0.trailing.equalToSuperview().inset(10)
            $0.top.bottom.equalToSuperview().inset(5)
            $0.width.equalTo(snp.height).inset(-6)
        })
    }
}
