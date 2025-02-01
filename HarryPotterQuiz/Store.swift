//
//  Store.swift
//  HarryPotterQuiz
//
//  Created by Berkin Demirel on 1.02.2025.
//

import Foundation
import StoreKit

@MainActor

enum BookStatus {
    case active
    case inactive
    case locked
}


class Store: ObservableObject {
    @Published var books: [BookStatus] = [.active, .active, .inactive, .locked, .locked, .locked, .locked]
    
    @Published var products: [Product] = []
    
    private var productIDs = ["hp4", "hp5", "hp6", "hp7"]
    
    func loadProducts() async {
        do {
            products = try await Product.products(for: productIDs)
        } catch {
            print("Couldn't fetch those products: \(error)")
        }
    }
}
