//
//  CustomButton.swift
//  NewsApiApp
//
//  Created by Leandro Diaz on 8/3/21.
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(backgroundColor: UIColor, title: String, color: UIColor) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        self.titleColor(for: .normal)
        setTitleColor(color, for: .normal)
    }
    
    private func configure(){
        layer.cornerRadius       = 5
        setTitleColor(.white, for: .normal)
        titleLabel?.font         = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(backgroundColor: UIColor, title: String){
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 50),
            widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}
