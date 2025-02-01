//
//  HarryPotterQuizApp.swift
//  HarryPotterQuiz
//
//  Created by Berkin Demirel on 9.12.2024.
//

import SwiftUI

@main
struct HarryPotterQuizApp: App {
    @StateObject private var store = Store()
    
    var body: some Scene {
        WindowGroup {
            MainPageView()
                .environmentObject(store)
                .task {
                    await store.loadProducts()
                }
        }
    }
}
