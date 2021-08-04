//
//  Extensions.swift
//  NewsApiApp
//
//  Created by Leandro Diaz on 8/3/21.
//

import UIKit
fileprivate var containerView: UIView!


extension UIViewController {
    func showCustomAlert(title: String, message: String, actionTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //Loading View for screens
    func showLoadingView(){
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor   = .systemBackground
        containerView.alpha             = 0
        
        UIView.animate(withDuration : 0.25) {
            containerView.alpha     = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        activityIndicator.startAnimating()
    }
    
    //dismissLoading View
    func dismissLoadingView() {
        DispatchQueue.main.async{
            containerView.removeFromSuperview()
        }
    }
    
    func hideNavBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.view.backgroundColor = .clear
        let menuBtn = UIButton(type: .custom)
        menuBtn.frame = CGRect(x: 0, y: 0, width: 45, height: 34)
        menuBtn.setImage(UIImage(systemName: "lineweight"), for: .normal)
        menuBtn.backgroundColor = .white
        menuBtn.tintColor = .black
        menuBtn.customShadow()
        let leftBtn = UIBarButtonItem(customView: menuBtn)
         
        navigationItem.leftBarButtonItem = leftBtn
        navigationItem.rightBarButtonItem = nil
        navigationItem.title = ""
    }
    
}

extension UIButton {
    func customShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 8.0
        self.layer.masksToBounds = false
    }
}
