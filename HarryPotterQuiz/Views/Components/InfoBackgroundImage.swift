//
//  InfoBackgroundImage.swift
//  HarryPotterQuiz
//
//  Created by Berkin Demirel on 5.01.2025.
//

import SwiftUI

struct InfoBackgroundImage: View {
    var body: some View {
        Image(.parchment)
            .resizable()
            .ignoresSafeArea()
            .background(.brown)
    }
}

#Preview {
    InfoBackgroundImage()
}
