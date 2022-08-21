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
        super.setUp()
        networkManager = MockNetworkManager()
    }
    
    override func tearDown() {
        super.tearDown()
        networkManager = nil
    }

    func testGetDesserts() throws {
        networkManager.getDesserts {
            (result: Result<[Dessert], DDError>) in
            switch result {
            case .success(let desserts):
                for (index, dessert) in desserts.enumerated() where index != desserts.count - 1 {
                    let next = desserts[index + 1]
                    XCTAssertTrue(dessert.name < next.name)
                }
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
