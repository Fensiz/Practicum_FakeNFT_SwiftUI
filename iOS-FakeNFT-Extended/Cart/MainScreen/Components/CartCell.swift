//
//  CartCell.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 04.10.2025.
//

import SwiftUI
import Kingfisher

struct CartCell: View {
	let cartItem: CartItem
	let removeAction: () -> Void

	var body: some View {
		HStack(spacing: DesignSystem.Spacing.large) {
			KFImage(cartItem.image)
				.resizable()
				.scaledToFit()
				.frame(
					width: DesignSystem.Sizes.imageMedium,
					height: DesignSystem.Sizes.imageMedium
				)
				.clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.small))
			VStack(alignment: .leading, spacing: DesignSystem.Spacing.medium) {
				VStack(alignment: .leading, spacing: DesignSystem.Spacing.xsmall) {
					Text(cartItem.name)
						.font(DesignSystem.Font.bodyBold)
						.lineLimit(1)
					RatingView(cartItem.rating)
				}
				.frame(height: DesignSystem.Sizes.elementSmallHeight)
				VStack(alignment: .leading, spacing: DesignSystem.Spacing.xxsmall) {
					Text("Цена")
						.font(DesignSystem.Font.caption2)
					Text(cartItem.priceText)
						.font(DesignSystem.Font.bodyBold)
						.lineLimit(1)
				}
			}
			.frame(maxWidth: .infinity, alignment: .leading)
			Button(action: removeAction) {
				Image(.cartCross)
					.foregroundStyle(DesignSystem.Color.textPrimary)
			}
			.buttonStyle(.plain)
		}
	}
}

#Preview {
	LightDarkPreviewWrapper {
		CartCell(cartItem: .mock1, removeAction: {})
			.border(.ypBlack)
	}
}
