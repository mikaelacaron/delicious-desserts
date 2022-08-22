//
//  Details.swift
//  DeliciousDesserts
//
//  Created by David Ruvinskiy on 8/17/22.
//

import Foundation

// MARK: - DessertDetailResponse
struct DessertDetailsResponse: Codable {
    let meals: [[String: String?]]
    
    static func filterDetails(response: DessertDetailsResponse) -> Details {
        let dict = response.meals[0]
        
        let mealName = (dict["strMeal"] ?? "") ?? ""
        let instructions = (dict["strInstructions"] ?? "") ?? ""
        var ingredients = [Ingredient]()
        
        for (key, value) in dict {
            guard key.starts(with: "strIngredient"), let value = value, !value.isEmpty else { continue }
            
            let ingredientNumber = key.suffix(1)
            let ingredientMeasure = (dict["strMeasure\(ingredientNumber)"] ?? "") ?? ""
            
            let ingredient = Ingredient(name: value.lowercased(), measurement: ingredientMeasure)
            ingredients.append(ingredient)
        }
        
        return Details(name: mealName, instructions: instructions, ingredients: ingredients)
    }
}

// MARK: - Detail
struct Details {
    let name: String
    let instructions: String
    let ingredients: [Ingredient]
}

// MARK: - Ingredient
struct Ingredient {
    let name: String
    let measurement: String
}
