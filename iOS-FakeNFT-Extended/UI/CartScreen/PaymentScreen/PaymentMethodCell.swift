//
//  PaymentMethodCell.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 12.10.2025.
//

import SwiftUI
import Kingfisher

struct PaymentMethodCell: View {
	let method: PaymentMethod
	let isSelected: Bool

	var body: some View {
		HStack(spacing: DesignSystem.Spacing.xsmall) {
			KFImage(method.image)
				.resizable()
				.scaledToFit()
				.background(.black)
				.clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.xsmall))
				.frame(width: DesignSystem.Sizes.imageXSmall, height: DesignSystem.Sizes.imageXSmall)
			VStack(alignment: .leading) {
				Text(method.title)
					.foregroundStyle(DesignSystem.Color.textPrimary)
				Text(method.name)
					.foregroundStyle(DesignSystem.Color.accent)
			}
			.font(DesignSystem.Font.caption2)
		}
		.frame(maxWidth: .infinity, alignment: .leading)
		.padding(.horizontal, DesignSystem.Padding.small)
		.padding(.vertical, DesignSystem.Padding.xsmall)
		.background(DesignSystem.Color.backgroundSecondary)
		.clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.small))
		.overlay {
			if isSelected {
				RoundedRectangle(cornerRadius: DesignSystem.Radius.small)
					.stroke(DesignSystem.Color.primary, lineWidth: DesignSystem.BorderWidth.small)
			}
		}
	}
}
