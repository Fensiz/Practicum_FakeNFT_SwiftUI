//
//  CartCell.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 04.10.2025.
//

import SwiftUI
import Kingfisher

struct CartCell: View {
	let removeAction: () -> Void
	let cartItem: CartItem
	var body: some View {
		HStack(spacing: 20) {
			KFImage(cartItem.image)
				.resizable()
				.scaledToFit()
				.frame(width: 108, height: 108)
				.clipShape(RoundedRectangle(cornerRadius: 12))
			VStack(alignment: .leading, spacing: 12) {
				VStack(alignment: .leading, spacing: 4) {
					Text(cartItem.name)
						.font(.system(size: 17, weight: .bold))
						.lineLimit(1)
					RatingView(cartItem.rating)
				}
				.frame(height: 38)
				VStack(alignment: .leading, spacing: 2) {
					Text("Цена")
						.font(.system(size: 13, weight: .regular))
					Text(cartItem.priceText)
						.font(.system(size: 17, weight: .bold))
						.lineLimit(1)
				}
			}
			.frame(maxWidth: .infinity, alignment: .leading)
			Button {
				removeAction()
			} label: {
				Image(.cartCross)
					.foregroundStyle(.ypBlack)
			}
			.buttonStyle(.plain)
		}
	}
}

#Preview {
	LightDarkPreviewWrapper {
		CartCell(
			removeAction: { print("remove")
			},
			cartItem: .init(
				id: "qwkpwoqkp",
				image: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Pink/Calder/1.png")!,
				name: "aijoijdioajoid",
				rating: 2,
				price: 22.2
			)
		)
		.border(.ypBlack)
	}
}
