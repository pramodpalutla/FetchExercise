//
//  Meal.swift
//  Fetch-Exercise
//
//  Created by Sai Palutla on 6/27/23.
//

import Foundation

// Response Models

struct Meals: Codable {
    let meals: [Meal]
}

struct Meal: Codable {
    let idMeal: String?
    let strMeal: String?
    let strDrinkAlternate: String?
    let strCategory: String?
    let strArea: String?
    let strInstructions: String?
    let strMealThumb: String?
    let strTags: String?
    let strYoutube: String?
    let ingredients: [Ingredient]
}

struct Ingredient: Codable {
    let name: String?
    let measure: String?
}

extension Meal {
    
    enum CodingKeys: CodingKey {
        case idMeal, strMeal, strDrinkAlternate, strCategory, strArea, strInstructions, strMealThumb, strTags, strYoutube
    }
    
    struct DynamicCodingKey: CodingKey {
        var stringValue: String
        var intValue: Int?
        
        init?(stringValue: String) {
            self.stringValue = stringValue
            self.intValue = nil
        }
        
        init?(intValue: Int) {
            self.stringValue = "\(intValue)"
            self.intValue = intValue
        }
    }
    
    
    // Custom Decoding
    
    init(from decoder: Decoder) throws {
        let decodeContainer = try decoder.container(keyedBy: CodingKeys.self)
        let dynamicDecodeContainer = try decoder.container(keyedBy: DynamicCodingKey.self)
        idMeal = try decodeContainer.decodeIfPresent(String.self, forKey: .idMeal)
        strMeal = try decodeContainer.decodeIfPresent(String.self, forKey: .strMeal)
        strDrinkAlternate = try decodeContainer.decodeIfPresent(String.self, forKey: .strDrinkAlternate)
        strCategory = try decodeContainer.decodeIfPresent(String.self, forKey: .strCategory)
        strArea = try decodeContainer.decodeIfPresent(String.self, forKey: .strArea)
        strInstructions = try decodeContainer.decodeIfPresent(String.self, forKey: .strInstructions)
        strMealThumb = try decodeContainer.decodeIfPresent(String.self, forKey: .strMealThumb)
        strTags = try decodeContainer.decodeIfPresent(String.self, forKey: .strTags)
        strYoutube = try decodeContainer.decodeIfPresent(String.self, forKey: .strYoutube)
        
        var ingredients: [Ingredient] = []
        
           for index in 1...20 {
               if let ingredientKey = DynamicCodingKey(stringValue: "strIngredient\(index)"),
                  let measureKey = DynamicCodingKey(stringValue: "strMeasure\(index)"),
                  let ingredient = try dynamicDecodeContainer.decodeIfPresent(String.self, forKey: ingredientKey),
                  let measure = try dynamicDecodeContainer.decodeIfPresent(String.self, forKey: measureKey)
               {
                   ingredients.append(Ingredient(name: ingredient, measure: measure))
               }
           }
           
           self.ingredients = ingredients
    }
}
