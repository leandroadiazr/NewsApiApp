//
//  DetailsViewCell.swift
//  NewsApiApp
//
//  Created by Leandro Diaz on 8/3/21.
//

import UIKit

class DetailsViewCell: UITableViewCell {
    
    static let reuseID  = "DetailsTableViewCell"
    let articleHeading = CustomLabel(textAlignment: .left, fontSize: 14, title: "")
    let titleLabel      = CustomLabel(textAlignment: .justified, fontSize: 15, title: "")
    let detailsLabel    = CustomBodyLabel(textAlignment: .justified, fontSize: 13)
    let newsImage       = NewsImageView(frame: .zero)
    let shareBtn        = CustomButton(backgroundColor: .white, title: "Share", color: .systemPurple)
    let artBtn          = CustomButton(backgroundColor: .systemPurple, title: "Full article", color: .white)
    
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
    
    
    func configureDetailsCell(article: Article) {
        articleHeading.text = article.source?.name ?? "H1"
        titleLabel.text = article.title
        detailsLabel.text = article.content
        guard let image = article.urlToImage else { return }
        newsImage.downloadImage(from: image)
    }
    
    private func configure() {
        titleLabel.numberOfLines    = 3
        articleHeading.textColor    = .systemGray
        detailsLabel.numberOfLines  = 0
        detailsLabel.lineBreakMode  = .byWordWrapping
        let labels = [titleLabel, articleHeading, detailsLabel]
        for label in labels {
            addSubview(label)
        }
        
        let btns = [shareBtn, artBtn]
        for btn in btns {
            addSubview(btn)
        }
        
        addSubview(newsImage)
        setupConstraints()
    }
    
    private func setupConstraints() {
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            newsImage.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            newsImage.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            newsImage.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            newsImage.heightAnchor.constraint(equalToConstant: 250),
            
            articleHeading.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: padding),
            articleHeading.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            articleHeading.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            
            titleLabel.topAnchor.constraint(equalTo: articleHeading.bottomAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo:  contentView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            
            detailsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            detailsLabel.leadingAnchor.constraint(equalTo:  contentView.leadingAnchor, constant: padding),
            detailsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor , constant: -padding),
            
            shareBtn.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            shareBtn.trailingAnchor.constraint(equalTo:  contentView.centerXAnchor, constant: -padding),
            shareBtn.heightAnchor.constraint(equalToConstant: 30),
            shareBtn.widthAnchor.constraint(equalToConstant: 100),
            
            artBtn.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            artBtn.leadingAnchor.constraint(equalTo:  contentView.centerXAnchor, constant: padding),
            artBtn.heightAnchor.constraint(equalToConstant: 30),
            artBtn.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}
