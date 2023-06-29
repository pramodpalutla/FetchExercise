//
//  MealDetailView.swift
//  Fetch-Exercise
//
//  Created by Sai Palutla on 6/28/23.
//

import SwiftUI

struct MealDetailView: View {
    @EnvironmentObject var mealListViewModel: MealListViewModel
    let meal: Meal
    
    // Meal Detail View
    var body: some View {
        ScrollView {
            ZStack(alignment: .center) {
                AsyncImage(url: URL(string: mealListViewModel.meal?.strMealThumb ?? ""))
                    .scaledToFit()
                    .shadow(radius: 5)
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width - 48, height: 200)
                    .clipped()
                
                    .overlay(alignment: .bottomTrailing, content: {
                        Text(mealListViewModel.meal?.strMeal ?? "")
                            .bold()
                            .foregroundColor(Color.white)
                            .background(Color.black)
                            .padding()
                    })

            }
            .cornerRadius(10)
            VStack(alignment: .leading, spacing: 16) {
               
                   
                   Text("Instructions:")
                    .font(.largeTitle)
                    .bold()
                   
                   Text(mealListViewModel.meal?.strInstructions ?? "")
                   
                   Text("Ingredients:")
                       .font(.largeTitle)
                       .bold()
               
                ForEach(0..<(mealListViewModel.meal?.ingredients.count ?? 20), id: \.self) { index in
                    Group {
                        let name = mealListViewModel.meal?.ingredients[index].name ?? ""
                        let measure = mealListViewModel.meal?.ingredients[index].measure ?? ""
                        if(!(name == "" && measure == "" || name == " " || measure == " ")) {
                            HStack {
                                Text(mealListViewModel.meal?.ingredients[index].name ?? "")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text(mealListViewModel.meal?.ingredients[index].measure ?? "")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        
                    }
   
                   }
               }
               .padding()
               .onAppear {
                   Task {
                       await mealListViewModel.fetchMealsById(mealId: self.meal.idMeal!)
                   }
               }
        }

       }
    


}

//struct MealDetailView_Previews: PreviewProvider {
//    static var previews: some View {
////        MealDetailView()
//    }
//}
