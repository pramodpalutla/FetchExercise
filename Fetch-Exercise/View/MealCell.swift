//
//  LocationSearchResultsCell.swift
//  QuickRide
//
//  Created by Sai Palutla on 5/15/23.
//

import SwiftUI


struct MealCell: View {
    let meal: Meal
    
    // Meal List Cell
    var body: some View {
        NavigationLink(destination: MealDetailView(meal: meal)) {
            ZStack {
                
                AsyncImage(url: URL(string: meal.strMealThumb!))
                    .scaledToFit()
                    .shadow(radius: 5)
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width - 48, height: 200)
                    .clipped()
                
                    .overlay(alignment: .bottomTrailing, content: {
                        Text(meal.strMeal!)
                            .bold()
                            .foregroundColor(Color.white)
                            .background(Color.black)
                            .padding()
                    })
            }
            
            .cornerRadius(10)
            .padding(.bottom, 8)
            
        }
        
        
        
    }
    
}


