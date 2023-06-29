//
//  Fetch_ExerciseApp.swift
//  Fetch-Exercise
//
//  Created by Sai Palutla on 6/27/23.
//

import SwiftUI

@main
struct FetchExerciseApp: App {
    @StateObject var mealListViewModel = MealListViewModel()
    var body: some Scene {
        WindowGroup {
            MealListView()
                .environmentObject(mealListViewModel)
        }
    }
}
