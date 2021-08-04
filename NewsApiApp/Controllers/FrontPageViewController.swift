//
//  FrontPageViewController.swift
//  NewsApiApp
//
//  Created by Leandro Diaz on 8/3/21.
//

import UIKit

class FrontPageViewController: UIViewController {
    
    var customTitle = CustomLabel(textAlignment: .center, fontSize: 32, title: "Front Page")
    var tableView                 : UITableView?
    var articles                  = [Article]()
    var page                      = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureTableView()
        getNews(page: page)
    }
    
    private func configureNavBar() {        
        self.navigationController?.navigationBar.isTranslucent = false
        let menuBtn = UIButton(type: .custom)
        menuBtn.setImage(UIImage(systemName: "lineweight"), for: .normal)
        menuBtn.tintColor = .label
        let leftBtn = UIBarButtonItem(customView: menuBtn)
        
        let searchBtn = UIButton(type: .custom)
        searchBtn.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchBtn.tintColor = .label
        let rightBtn = UIBarButtonItem(customView: searchBtn)
        
        navigationItem.title = customTitle.text
        navigationItem.leftBarButtonItem = leftBtn
        navigationItem.rightBarButtonItem = rightBtn
    }
    
    private func configureTableView() {
        tableView                       = UITableView(frame: .zero, style: .plain)
        tableView?.frame                = view.bounds
        tableView?.delegate             = self
        tableView?.dataSource           = self
        tableView?.prefetchDataSource   = self
        tableView?.rowHeight            = 90
        tableView?.register(FrontPageViewCell.self, forCellReuseIdentifier: FrontPageViewCell.reuseID)
        tableView?.register(FrontPageMainViewCell.self, forCellReuseIdentifier: FrontPageMainViewCell.reuseID)
        
        guard let tableView = tableView else {return }
        view.addSubview(tableView)
    }
    
    private func getNews(page: Int) {
        showLoadingView()
        NetworkManager.shared.getData(for: page) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                if data == nil {
                    DispatchQueue.main.async {
                        self.showCustomAlert(title: "Error", message: "Couldn't Load News, Please check your Network Connection", actionTitle: "Ok")
                    }
                } else {
                    data?.articles.forEach {
                        self.articles.append($0)
                    }
                    
                    DispatchQueue.main.async {
                        self.tableView?.reloadData()
                        self.view.bringSubviewToFront(self.tableView!)
                    }
                    self.page += 1
                    self.dismissLoadingView()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showCustomAlert(title: "Error", message: error.rawValue, actionTitle: "Ok")
                }
            }
        }
    }
}

extension FrontPageViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for index in indexPaths {
            if index.row > articles.count {
                getNews(page: page)
                print(page)
            }
        }
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let mainCell = tableView.dequeueReusableCell(withIdentifier: FrontPageMainViewCell.reuseID, for: indexPath) as! FrontPageMainViewCell
            let article = articles[indexPath.row]
            mainCell.configureMainCell(article: article)
            return mainCell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FrontPageViewCell.reuseID, for: indexPath) as! FrontPageViewCell
        let movie = articles[indexPath.row]
        cell.configureArticleCell(article: movie)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article     = articles[indexPath.row]
        let detailsVC   = DetailsViewController()
        detailsVC.articles.append(article)
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 310
        }
        return 90
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height * 2.5
        let contentYoffSet = scrollView.contentOffset.y
        let distance = scrollView.contentSize.height - contentYoffSet
        
        if distance < height {
            hideNavBar()
        }else {
            configureNavBar()
        }
    }
    
}



