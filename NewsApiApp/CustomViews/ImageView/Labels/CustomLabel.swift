//
//  CustomLabel.swift
//  NewsApiApp
//
//  Created by Leandro Diaz on 8/3/21.
//

import UIKit

class CustomLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat, title: String) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.text = title
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .semibold)
    }
    
    private func configure(){
        font = UIFont(name: "LibreFranklin-Italic-VariableFont_wght.ttf", size: 18)
        adjustsFontSizeToFitWidth    = true
        minimumScaleFactor           = 0.90
        lineBreakMode                = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }

}
