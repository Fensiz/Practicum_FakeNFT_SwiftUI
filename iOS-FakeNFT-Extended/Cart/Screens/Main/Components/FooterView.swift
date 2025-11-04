//
//  FooterView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 12.10.2025.
//

import SwiftUI

struct FooterView: View {
	let totalCount: Int
	let totalPrice: Double
	let payAction: () -> Void

	var body: some View {
		DesignSystem.Color.backgroundSecondary
			.frame(height: DesignSystem.Sizes.elementMediumHeight)
			.clipShape(.rect(
				topLeadingRadius: DesignSystem.Radius.medium,
				bottomLeadingRadius: .zero,
				bottomTrailingRadius: .zero,
				topTrailingRadius: DesignSystem.Radius.medium
			))
			.overlay {
				HStack {
					VStack(alignment: .leading) {
						Text("\(totalCount) NFT")
							.font(DesignSystem.Font.bodyRegular)
							.foregroundStyle(DesignSystem.Color.textPrimary)
							.lineLimit(1)
						HStack(spacing: .zero) {
							Text(String(format: "%.2f", totalPrice).replacingOccurrences(of: ".", with: ","))
							Text(" ETH")
						}
						.font(DesignSystem.Font.bodyBold)
						.foregroundStyle(DesignSystem.Color.accent)
						.lineLimit(1)
					}
					.frame(maxWidth: .infinity, alignment: .leading)
					Button("К оплате", action: payAction)
						.buttonStyle(PrimaryButtonStyle())
						.frame(
							width: DesignSystem.Sizes.buttonMediumWidth,
							height: DesignSystem.Sizes.buttonSmallHeight
						)
				}
				.padding(.horizontal, DesignSystem.Padding.medium)
			}
	}
}

#Preview {
	FooterView(totalCount: 5, totalPrice: 11.3, payAction: {})
}
