//
//  PrimaryButtonModifier.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 12.10.2025.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.font(.system(size: 17, weight: .bold))
			.frame(maxWidth: .infinity, minHeight: 44, maxHeight: 60)
			.background(.ypBlack)
			.foregroundStyle(.ypWhite)
			.clipShape(RoundedRectangle(cornerRadius: 16))
			.opacity(configuration.isPressed ? 0.7 : 1.0)
	}
}

#Preview {
	Button("Tap me") {
		print("Button 1 pressed")
	}
	.buttonStyle(PrimaryButtonStyle())
}
