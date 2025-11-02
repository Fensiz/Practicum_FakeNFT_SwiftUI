//
//  OpenWebsiteButton.swift
//  iOS-FakeNFT-Extended
//
//  Created by Алина on 18.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//
import SwiftUI

struct BorderedButtonStyle: ButtonStyle {

    let font: Font
    let textColor: Color
    let color: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(font)
            .foregroundStyle(textColor)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .frame(minHeight: 44)
            .background(
                RoundedRectangle(cornerRadius: DesignSystem.Radius.medium, style: .continuous)
                    .fill(color)
            )
            .overlay(
                RoundedRectangle(cornerRadius: DesignSystem.Radius.medium, style: .continuous)
                    .stroke(textColor, lineWidth: DesignSystem.BorderWidth.small)
                    .allowsHitTesting(false)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

#Preview {
    let title = "Перейти на сайт пользователя"

    Button(title) { print("Tapped button") }
        .buttonStyle(
            BorderedButtonStyle(
                font: Font(UIFont.caption1),
                textColor: .ypBlack,
                color: .ypWhite
            )
        )
}
