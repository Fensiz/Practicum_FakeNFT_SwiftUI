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
		VStack(spacing: 20) {
			Spacer()
			Image(.success)
			Text("Успех! Оплата прошла,\nпоздравляем с покупкой")
				.font(.system(size: 22, weight: .bold))
				.foregroundStyle(.ypBlack)
				.multilineTextAlignment(.center)
			Spacer()
			Button("Вернуться в корзину", action: action)
				.buttonStyle(PrimaryButtonStyle())
				.padding(16)
		}
		.background(.ypWhite)
		.navigationBarBackButtonHidden(true)
	}
}

#Preview {
	SuccessPaymentScreen(action: {})
}
