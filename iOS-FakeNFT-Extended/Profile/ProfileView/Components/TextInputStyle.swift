//
//  TextInputStyle.swift
//  iOS-FakeNFT-Extended
//
//  Created by mac on 11.10.2025.
//

import SwiftUI

/// Стили для текстовых полей в редкатировании профиля
struct TextInputStyle: ViewModifier {
	func body(content: Content) -> some View {
		content
			.font(DesignSystem.Font.bodyRegular)
			.padding(.vertical, 11)
			.padding(.horizontal)
			.background(Color.ypLightGrey.cornerRadius(12))
	}
}
