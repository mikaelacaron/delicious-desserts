//
//  DeliciousDessertsTests.swift
//  DeliciousDessertsTests
//
//  Created by David Ruvinskiy on 8/20/22.
//

import XCTest
@testable import DeliciousDesserts

class DeliciousDessertsTests: XCTestCase {
    
    var networkManager: NetworkManagerProtocol!
    
    override func setUp() {
        networkManager = MockNetworkManager()
    }

    func testGetDesserts() throws {
        networkManager.getDesserts {
            (result: Result<[Dessert], DDError>) in
            switch result {
            case .success(let desserts):
                XCTAssertEqual(desserts, desserts.sorted())
            case .failure(_):
                break
            }
        }
    }
    
    func testGetDetails() throws {
        networkManager.getDetails(for: "53049") {
            (result: Result<Details, DDError>) in
            switch result {
            case .success(let details):
                for ingredient in details.ingredients {
                    XCTAssertTrue(!ingredient.name.isEmpty)
                    XCTAssertTrue(!ingredient.measurement.isEmpty)
                }
            case .failure(_):
                break
            }
        }
    }
}
