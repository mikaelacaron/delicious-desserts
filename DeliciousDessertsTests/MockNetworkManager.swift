//
//  MockNetworkManager.swift
//  DeliciousDessertsTests
//
//  Created by David Ruvinskiy on 8/20/22.
//

import Foundation
@testable import DeliciousDesserts

final class MockNetworkManager: NetworkManagerProtocol, Mockable {
    func getDesserts(completed: @escaping (Result<[Dessert], DDError>) -> Void) {
        let dessertResponse = loadJSON(filename: "DessertResponse", type: DessertResponse.self)
        completed(.success(dessertResponse.meals))
    }
    
    func getDetails(for id: String, completed: @escaping (Result<Details, DDError>) -> Void) {
        let response = loadJSON(filename: "DessertDetailsResponse", type: DessertDetailsResponse.self)
        let details = DessertDetailsResponse.filterDetails(response: response)
        completed(.success(details))
    }
}
