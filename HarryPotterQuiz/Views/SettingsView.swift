//
//  SettingsView.swift
//  HarryPotterQuiz
//
//  Created by Berkin Demirel on 12.01.2025.
//

import SwiftUI


struct SettingsView: View {
    @EnvironmentObject private var store: Store
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            InfoBackgroundImage()
            
            VStack {
                Text("Which books would you like to see questions from?")
                    .font(.title)
                    .multilineTextAlignment(.center)
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(), GridItem()]) {
                        ForEach(0..<7) { i in
                            if store.books[i] == .active {
                                ZStack(alignment: .bottomTrailing) {
                                    Image("hp\(i + 1)")
                                        .resizable()
                                        .scaledToFit()
                                        .shadow(radius: 8)
                                    
                                    Image(systemName: "checkmark.circle.fill")
                                        .font(.largeTitle)
                                        .imageScale(.large)
                                        .foregroundStyle(.green)
                                        .padding(2)
                                }
                                .onTapGesture {
                                    store.books[i] = .inactive
                                }
                            } else if store.books[i] == .inactive {
                                ZStack(alignment: .bottomTrailing) {
                                    Image("hp\(i + 1)")
                                        .resizable()
                                        .scaledToFit()
                                        .shadow(radius: 8)
                                    
                                    Image(systemName: "circle")
                                        .font(.largeTitle)
                                        .imageScale(.large)
                                        .foregroundStyle(.green)
                                        .padding(2)
                                }
                                .overlay(Rectangle().opacity(0.33))
                                .onTapGesture {
                                    store.books[i] = .active
                                }
                            } else {
                                ZStack() {
                                    Image("hp\(i + 1)")
                                        .resizable()
                                        .scaledToFit()
                                        .shadow(radius: 8)
                                        .overlay(Rectangle().opacity(0.75))
                                    
                                    Image(systemName: "lock.fill")
                                        .font(.largeTitle)
                                        .imageScale(.large)
                                        .shadow(color: .white.opacity(0.75), radius: 4)
                                        .padding(2)
                                }
                            }
                        }
                    }
                }
                Button("Done") {
                    dismiss()
                }
                .doneButtonStyle()
            }
        }
    }
}

struct BookGridView: View {
    let imageName: String
    let isSelected: Bool
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .shadow(radius: 8)
            
            Image(systemName: isSelected
                  ? "checkmark.circle.fill"
                  : "circle")
            .font(.largeTitle)
            .imageScale(.large)
            .foregroundStyle(.green)
            .padding(2)
        }
        .overlay(Rectangle().opacity(isSelected ? 0 : 0.33))
    }
}

#Preview {
    SettingsView()
        .environmentObject(Store())
}

