//
//  Button+Ext.swift
//  HarryPotterQuiz
//
//  Created by Berkin Demirel on 5.01.2025.
//

import SwiftUI

extension Button {
    func doneButtonStyle() -> some View {
        self
            .font(.largeTitle)
            .padding()
            .buttonStyle(.borderedProminent)
            .tint(.brown)
            .foregroundStyle(.white)
    }
}
