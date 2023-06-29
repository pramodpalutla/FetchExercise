//
//  MealListViewModel.swift
//  Fetch-Exercise
//
//  Created by Sai Palutla on 6/27/23.
//

import Foundation

class MealListViewModel: ObservableObject {
    @Published var mealsList : [Meal]?
    @Published var meal : Meal?
    
    func fetchMealsByCategory() async {
        do {
            let desserts = try await WebService().getAllMealsInCategory(category: "Dessert")
            DispatchQueue.main.async {
                self.mealsList = desserts
            }
            
           
        } catch {
            
        }
        
    }
    
    func fetchMealsById(mealId: String) async {
        do {
            let meals = try await WebService().getMealById(mealId: mealId)
            DispatchQueue.main.async {
                self.meal = meals[0]
                print(meals[0])
            }

        } catch {
            
        }
        
        
    }
    
    
}
