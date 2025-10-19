//
//  NFTCardView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vladimir on 19.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import SwiftUI

struct NFTCardView: View {

	private let name: String
	private let imageURL: URL?
	private let rating: Int
	private let price: Double
	private let currency: Currency
	private let isFavorite: Bool
	private let isAddedToCart: Bool

	private var priceString: String {
		Decimal(price)
			.formatted(.number.precision(.fractionLength(0...2)))
	}

	init(
		name: String,
		imageURL: URL?,
		rating: Int,
		price: Double,
		currency: Currency,
		isFavorite: Bool,
		isAddedToCart: Bool
	) {
		self.name = name
		self.imageURL = imageURL
		self.rating = rating
		self.price = price
		self.currency = currency
		self.isFavorite = isFavorite
		self.isAddedToCart = isAddedToCart
	}

	var body: some View {
		VStack(spacing: 8) {
			nftImage
			nftDetails
		}
		.frame(height: 192)
	}

	var nftImage: some View {
		AsyncImage(url: imageURL) { phase in
			switch phase {
			case .empty:
				VStack(spacing: .zero) {
					Spacer()
					ProgressView()
						.tint(.ypBlack)
					Spacer()
				}
			case .success(let image):
				image
					.resizable()
					.scaledToFit()
					.overlay(alignment: .topTrailing) {
						Image(isFavorite ? .active : .noActive)
							.foregroundStyle(isFavorite ? .ypURed : .ypUWhite)
					}
			case .failure:
				Image(systemName: "exclamationmark.triangle.fill")
			@unknown default:
				Image(systemName: "exclamationmark.triangle.fill")
			}
		}
		.clipShape(RoundedRectangle(cornerRadius: 12))
	}

	var nftDetails: some View {
		VStack(alignment: .leading, spacing: 4) {
			RatingView(rating)
			HStack(spacing: .zero) {
				VStack(alignment: .leading, spacing: 4) {
					Group {
						Text(name)
							.font(.system(size: 17, weight: .bold))
					Text("\(priceString) \(currency.rawValue.uppercased())")
					}
					.foregroundStyle(.ypBlack)
				}
				Spacer()
				Image(isAddedToCart ? .cartCross : .cart)
					.foregroundStyle(.ypBlack)
			}
		}
	}

}

// MARK: - Preview
#Preview {
	HStack {
		NFTCardView(
			name: "Test name",
			imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Ellsa/1.png"),
			rating: 3,
			price: 31.12,
			currency: .eth,
			isFavorite: true,
			isAddedToCart: true
		)
		NFTCardView(
			name: "Test name",
			imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Ellsa/1.png"),
			rating: 0,
			price: 31,
			currency: .eth,
			isFavorite: false,
			isAddedToCart: false
		)
	}
}
