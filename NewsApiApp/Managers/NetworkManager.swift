//
//  NetworkManager.swift
//  NewsApiApp
//
//  Created by Leandro Diaz on 8/3/21.
//

import Foundation

import UIKit

class NetworkManager {
    let cache = NSCache<NSString, UIImage >()
    static let shared = NetworkManager()
    let newsURL = "https://newsapi.org/v2/everything?q=bitcoin&language=&pageSize=100&"
    let key = "923eef7364e44455a09379623b112582"
    
    func getData(for page: Int, completed: @escaping (Result<News?, ErrorMessage> ) -> Void) {
        let endPoint = "\(newsURL)&page=\(page)&apiKey=\(key)"

        guard let url = URL(string: endPoint) else {
            completed(.failure(.invalidRequest))
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(.failure(.invalidRequest))
                return
            }
            
            guard let result = response as? HTTPURLResponse, result.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let receivedData = try decoder.decode(News.self, from: data)
                completed(.success(receivedData))
            } catch {
                completed(.failure(.unableToComplete))
            }
        }
        dataTask.resume()
    }
}
