//
//  MainCell.swift
//  NewsApiApp
//
//  Created by Leandro Diaz on 8/3/21.
//

import UIKit

class FrontPageMainViewCell: UITableViewCell {
    
    static let reuseID  = "MainTableViewCell"
    let articleHeading  = CustomLabel(textAlignment: .left, fontSize: 14, title: "")
    let titleLabel      = CustomLabel(textAlignment: .justified, fontSize: 15, title: "")
    let newsImage       = NewsImageView(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureMainCell(article: Article) {
        articleHeading.text = article.source?.name ?? "H1"
        titleLabel.text     = article.title
        guard let image     = article.urlToImage else { return }
        newsImage.downloadImage(from: image)
    }
    
    private func configure() {
        titleLabel.numberOfLines = 3
        articleHeading.textColor = .systemGray
        let labels = [titleLabel, articleHeading]
        for label in labels {
            addSubview(label)
        }
        addSubview(newsImage)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            newsImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            newsImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            newsImage.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            newsImage.heightAnchor.constraint(equalToConstant: 200),
            
            articleHeading.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: 2),
            articleHeading.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            articleHeading.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            
            titleLabel.topAnchor.constraint(equalTo: articleHeading.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
        ])
    }
}
