//
//  SuccessPaymentScreen.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 12.10.2025.
//

import SwiftUI

struct SuccessPaymentScreen: View {
	let action: () -> Void
	var body: some View {
		VStack(spacing: DesignSystem.Spacing.large) {
			Spacer()
			Image(.success)
			Text("Успех! Оплата прошла,\nпоздравляем с покупкой")
				.font(DesignSystem.Font.headline3)
				.foregroundStyle(DesignSystem.Color.textPrimary)
				.multilineTextAlignment(.center)
			Spacer()
			Button("Вернуться в корзину", action: action)
				.buttonStyle(PrimaryButtonStyle())
				.padding(DesignSystem.Padding.medium)
		}
		.background(DesignSystem.Color.background)
		.navigationBarBackButtonHidden(true)
	}
}

#Preview {
	SuccessPaymentScreen(action: {})
}
