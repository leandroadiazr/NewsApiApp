//
//  NewsImageView.swift
//  NewsApiApp
//
//  Created by Leandro Diaz on 8/3/21.
//

import UIKit

class NewsImageView: UIImageView {
    let cache               = NetworkManager.shared.cache
    let placheHolderImage   = UIImage(systemName: "newspaper")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        image               = placheHolderImage
        clipsToBounds       = true
        contentMode = .scaleAspectFit
        translatesAutoresizingMaskIntoConstraints = false
    }

    //Not handling errors intentionally
    func downloadImage(from urlString: String) {
        let cacheKey    = NSString(string: urlString)
        if let image    = cache.object(forKey: cacheKey) {
            self.image  = image
            return
        }
        
        guard let url = URL(string: urlString) else { return }        
        let task = URLSession.shared.dataTask(with: url) {[weak self] (data, response, error) in
            guard let self = self else { return }
            if error != nil { return }
            guard let result    = response as? HTTPURLResponse, result.statusCode == 200 else { return }
            guard let data      = data else { return }
            guard let image     = UIImage(data: data) else { return }
    
            self.cache.setObject(image, forKey: cacheKey)
    
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
}
