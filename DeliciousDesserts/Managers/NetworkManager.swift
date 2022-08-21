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
    
    private var baseUrl: String
    
    init(baseUrl: String = "https://www.themealdb.com/api/json/v1/1/") {
        self.baseUrl = baseUrl
    }
    
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
