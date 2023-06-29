//
//  WebService.swift
//  Fetch-Exercise
//
//  Created by Sai Palutla on 6/27/23.
//

import Foundation

// Networking Layer API Calls - Static Methods

class WebService {
    
   class func getMealById(mealId: String) async throws -> [Meal] {
        let request = URLRequest(url: URL.forMealId(mealId))
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        let (data, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else {
            throw NetworkError.invalidResponse
        }
        
        guard let result = try? JSONDecoder().decode(Meals.self, from: data) else {
            throw NetworkError.decodingError
        }
        
        return result.meals
    }
    
   class func getAllMealsInCategory(category: String) async throws -> [Meal] {
        let request = URLRequest(url: URL.forAllMealsInCategory(category))
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        let (data, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else {
            throw NetworkError.invalidResponse
        }
        
        guard let result = try? JSONDecoder().decode(Meals.self, from: data) else {
            throw NetworkError.decodingError
        }
        
        return result.meals
    }
}

extension URL {
    
    static func forMealId(_ id: String) -> URL {
        return URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)")!
    }
    
    static func forAllMealsInCategory(_ category: String) -> URL {
        return URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=\(category)")!
    }
}


enum NetworkError: Error {
    case invalidResponse
    case badUrl
    case decodingError
}
