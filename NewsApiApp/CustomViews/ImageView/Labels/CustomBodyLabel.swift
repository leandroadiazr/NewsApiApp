//
//  CustomBodyLabel.swift
//  NewsApiApp
//
//  Created by Leandro Diaz on 8/3/21.
//

import UIKit

class CustomBodyLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .light)
    }
    
    
    private func configure(){
        font = UIFont(name: "Merriweather-Bold.ttf", size: 12)
        textColor                    = .label
        adjustsFontSizeToFitWidth    = true
        minimumScaleFactor           = 0.75
        lineBreakMode                = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
