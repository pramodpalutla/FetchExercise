//
//  ContentView.swift
//  Fetch-Exercise
//
//  Created by Sai Palutla on 6/27/23.
//

import SwiftUI

struct MealListView: View {
    @EnvironmentObject var mealListViewModel: MealListViewModel
    
    // Meal List in navigation stack for Master - Detail
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Desserts")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.leading, 4)
                
                ScrollView {
                    VStack(alignment: .leading) {
                        if let meals = mealListViewModel.mealsList {
                            ForEach(meals, id: \.idMeal) { meal in
                                MealCell(meal: meal)
            
                            }
                        } else {
                            Text("Loading desserts...")
                                .italic()
                        }
                       
                    }
                }
            }
            .padding()
            .onAppear {
                mealListViewModel.meal = nil
                Task {
                    await mealListViewModel.fetchMealsByCategory()
                    
                }
                
                
            }
        }
  
        
    }
    
}

struct MealListView_Previews: PreviewProvider {
    static var previews: some View {
        MealListView()
    }
}
