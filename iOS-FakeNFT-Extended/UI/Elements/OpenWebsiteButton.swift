//
//  OpenWebsiteButton.swift
//  iOS-FakeNFT-Extended
//
//  Created by Алина on 18.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//
import SwiftUI

struct OpenWebsiteButton: View {

    let title: String
    let font: Font
    let textColor: Color
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(font)
                .foregroundStyle(textColor)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
        }
        .background(color, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
        .contentShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(textColor, lineWidth: 1)
                .allowsHitTesting(false)
        )
    }
}

#Preview {
    let title = "Перейти на сайт пользователя"
    let action = { print("Tapped button") }

    OpenWebsiteButton(title: title, font: Font(UIFont.caption1),
                      textColor: .ypBlack, color: .ypWhite, action: action)
        .padding(.horizontal, 20)
}
