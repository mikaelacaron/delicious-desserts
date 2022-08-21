//
//  Dessert.swift
//  DeliciousDesserts
//
//  Created by David Ruvinskiy on 8/16/22.
//

import Foundation

// MARK: - DessertResponse
struct DessertResponse: Codable {
    var meals: [Dessert]
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        meals = try values.decode([Dessert].self, forKey: .meals).sorted()
    }
    
    enum CodingKeys: String, CodingKey {
        case meals
    }
}

// MARK: - Dessert
struct Dessert: Codable, Comparable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
    
    static func < (lhs: Dessert, rhs: Dessert) -> Bool {
        return lhs.strMeal < rhs.strMeal
    }
}
