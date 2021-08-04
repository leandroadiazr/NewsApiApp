//
//  DetailsViewController.swift
//  NewsApiApp
//
//  Created by Leandro Diaz on 8/3/21.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var tableView: UITableView?
    var articles = [Article]()
    let backBtn = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureNavBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func configureNavBar() {
        self.navigationController?.navigationBar.isHidden = true
        backBtn.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        backBtn.tintColor = .label
        backBtn.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        backBtn.backgroundColor = .white
        backBtn.customShadow()
        view.addSubview(backBtn)
        setupConstraints()
    }
    
    @objc func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    private func configureTableView() {
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView?.frame = view.bounds
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.rowHeight = CGFloat(self.view.bounds.height / 1.3)
        tableView?.isScrollEnabled = false
        tableView?.allowsSelection = false
        
        tableView?.register(DetailsViewCell.self, forCellReuseIdentifier: DetailsViewCell.reuseID)
        
        guard let tableView = tableView else { return }
        view.addSubview(tableView)
    }
}

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailsViewCell.reuseID, for: indexPath) as! DetailsViewCell
        let article = articles[indexPath.row]
        cell.configureDetailsCell(article: article)
        return cell
    }
}

extension DetailsViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backBtn.widthAnchor.constraint(equalToConstant: 74),
            backBtn.heightAnchor.constraint(equalToConstant: 54),
        ])
    }
}
