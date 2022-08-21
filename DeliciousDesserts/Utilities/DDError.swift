//
//  DDError.swift
//  DeliciousDesserts
//
//  Created by David Ruvinskiy on 8/16/22.
//

import Foundation

enum DDError: String, Error {
    
    case invalidURL = "There was an issue connecting to the server. If this persists, please contact support."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
}
