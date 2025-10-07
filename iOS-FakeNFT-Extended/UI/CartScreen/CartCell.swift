//
//  CartCell.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 04.10.2025.
//

import SwiftUI

struct CartCell: View {
	let removeAction: () -> Void
	let cartItem: CartItem
	var body: some View {
		HStack(spacing: 20) {
			cartItem.image
				.resizable()
				.scaledToFit()
				.frame(width: 108, height: 108)
				.cornerRadius(12)
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
		}
	}
}

#Preview {
	LightDarkPreviewWrapper {
		CartCell(
			removeAction: { print("remove") },
			cartItem: .init(image: Image(.mock1), name: "Springfieldowquidwqhhudqwiuhdqwiuhdqiwuhdiwquhdiwq", rating: 4, price: 212324234234234234231.6789)
		)
		.border(.ypBlack)
		CartCell(
			removeAction: { print("remove") },
			cartItem: .init(image: Image(.mock1), name: "Spring", rating: 4, price: 1.87)
		)
		.border(.ypBlack)
	}
}
