//
//  PrimaryButtonModifier.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 12.10.2025.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
	let cornerRadius: CGFloat
	let foregroundColor: Color
	let font: Font

	init(
		cornerRadius: CGFloat = DesignSystem.Radius.medium,
		foregroundColor: Color = DesignSystem.Color.buttonText,
		font: Font = DesignSystem.Font.bodyBold
	) {
		self.cornerRadius = cornerRadius
		self.foregroundColor = foregroundColor
		self.font = font
	}

	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.font(font)
			.frame(
				maxWidth: .infinity,
				minHeight: DesignSystem.Sizes.buttonSmallHeight,
				maxHeight: DesignSystem.Sizes.buttonLargeHeight
			)
			.background(DesignSystem.Color.buttonBackground)
			.foregroundStyle(foregroundColor)
			.clipShape(RoundedRectangle(cornerRadius: cornerRadius))
			.opacity(configuration.isPressed ? 0.7 : 1.0)
	}
}

#Preview {
	Button("Tap me") {
		print("Button 1 pressed")
	}
	.buttonStyle(PrimaryButtonStyle())
}
