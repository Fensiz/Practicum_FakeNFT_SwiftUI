//
//  NFTCardView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vladimir on 19.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import SwiftUI
import Kingfisher

struct NFTCardView: View {

	private let model: NFTCardModel
	private let onCartTap: () -> Void
	private let onFavoriteTap: () -> Void

	@State private var shouldUseErrorImage = false

	private let imageSize: CGFloat = 108

	private var priceString: String {
		Decimal(model.price)
			.formatted(.number.precision(.fractionLength(0...2)))
	}

	init(
		model: NFTCardModel,
		onCartTap: @escaping () -> Void,
		onFavoriteTap: @escaping () -> Void
	) {
		self.model = model
		self.onCartTap = onCartTap
		self.onFavoriteTap = onFavoriteTap
	}

	var body: some View {
		VStack(spacing: 8) {
			image
			nftDetails
		}
		.frame(width: imageSize)
	}

	private var image: some View {
		BasicImage(imageURL: model.imageURL, contentMode: .fill)
		.frame(width: imageSize, height: imageSize)
		.clipShape(RoundedRectangle(cornerRadius: 12))
		.overlay(alignment: .topTrailing) {
			Button(action: onFavoriteTap) {
				Image(model.favorite ? .active : .noActive)
					.foregroundStyle(model.favorite ? .ypURed : .ypUWhite)
			}
		}
	}

	private var nftDetails: some View {
		VStack(alignment: .leading, spacing: 4) {
			RatingView(model.rating)
			HStack(alignment: .top, spacing: .zero) {
				VStack(alignment: .leading, spacing: 4) {
					Group {
						Text(model.name)
							.lineLimit(2)
							.font(.system(size: 17, weight: .bold))
                            .minimumScaleFactor(0.5)
						Text("\(priceString) \(model.currency.rawValue.uppercased())")
							.font(.system(size: 10, weight: .medium))
					}
					.foregroundStyle(.ypBlack)
				}
				Spacer()
				Button(action: onCartTap) {
					Image(model.addedToCart ? .cartCross : .cart)
						.foregroundStyle(.ypBlack)
				}
			}
		}
	}

}

// MARK: - Preview
#Preview {
	HStack {
		NFTCardView(model: .init(
			name: "Test name",
			imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Ellsa/1.png"),
			rating: 3,
			price: 31.12,
			currency: .eth,
			favorite: true,
			addedToCart: true,
		),
					onCartTap: {},
					onFavoriteTap: {}
		)
		NFTCardView(model: .init(
			name: "Test name",
			imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Ellsa/1.png"),
			rating: 0,
			price: 31,
			currency: .eth,
			favorite: false,
			addedToCart: false,
		),
					onCartTap: {},
					onFavoriteTap: {}
		)
		NFTCardView(model: .init(
			name: "Test name",
			imageURL: URL(string: "https://code.s3.yande.net/Mobile/iOS/NFT/Beige/Ellsa/1.png"),
			rating: 0,
			price: 31.1,
			currency: .eth,
			favorite: false,
			addedToCart: false,
		),
					onCartTap: {},
					onFavoriteTap: {}
		)
	}
}
