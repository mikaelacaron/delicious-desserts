//
//  NetworkManager.swift
//  DeliciousDesserts
//
//  Created by David Ruvinskiy on 8/16/22.
//

import UIKit

protocol NetworkManagerProtocol {
    func getDesserts(completed: @escaping (Result<[Dessert], DDError>) -> Void)
    func getDetails(for id: String, completed: @escaping (Result<Details, DDError>) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    
    private var baseUrl = "https://www.themealdb.com/api/json/v1/1/"
    let cache = NSCache<NSString, UIImage>()
    
    func getDesserts(completed: @escaping (Result<[Dessert], DDError>) -> Void) {
        let endpoint = baseUrl + "filter.php?c=Dessert"
        
        fetchGenericJSONData(urlString: endpoint) { (result: Result<DessertResponse, DDError>) in
            switch result {
            case .success(let response):
                completed(.success(response.meals))
            case .failure(let error):
                completed(.failure(error))
            }
        }
    }
    
    func getDetails(for id: String, completed: @escaping (Result<Details, DDError>) -> Void) {
        let endpoint = baseUrl + "lookup.php?i=\(id)"
        
        fetchGenericJSONData(urlString: endpoint) { (result: Result<DessertDetailsResponse, DDError>) in
            switch result {
            case .success(let response):
                let details = DessertDetailsResponse.filterDetails(response: response)
                
                completed(.success(details))
            case .failure(let error):
                completed(.failure(error))
            }
        }
    }
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                      completed(nil)
                      return
                  }
            
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        
        task.resume()
    }
    
    private func fetchGenericJSONData<T: Decodable>(urlString: String, completed: @escaping (Result<T, DDError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidResponse))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(T.self, from: data)
                completed(.success(decodedResponse))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
}
