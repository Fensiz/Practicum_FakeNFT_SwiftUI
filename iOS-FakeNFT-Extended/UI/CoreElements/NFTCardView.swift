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

	@State private var shouldUseErrorImage = false

	private let model: NFTCardViewModel

	private let imageSize: CGFloat = 108

	private var priceString: String {
		Decimal(model.price)
			.formatted(.number.precision(.fractionLength(0...2)))
	}

	init(
		model: NFTCardViewModel
	) {
		self.model = model
	}

	var body: some View {
		VStack(spacing: 8) {
			nftImage
			nftDetails
		}
		.frame(width: imageSize)
	}

	@ViewBuilder
	private var nftImage: some View {
		Group {
			if shouldUseErrorImage {
				errorImage
			} else {
				kfImage
			}
		}
		.frame(width: imageSize, height: imageSize)
		.clipShape(RoundedRectangle(cornerRadius: 12))
		.overlay(alignment: .topTrailing) {
			Button(action: model.onFavoriteTap) {
				Image(model.isFavorite ? .active : .noActive)
					.foregroundStyle(model.isFavorite ? .ypURed : .ypUWhite)
			}
		}
	}

	private var kfImage: some View {
		KFImage(model.imageURL)
			.resizable()
			.placeholder { progress in
				placeholder(progressFraction: progress.fractionCompleted)
			}
			.onFailure { _ in
				// onFailureImage not working
				shouldUseErrorImage = true
			}
			.scaledToFill()
	}

	private func placeholder(progressFraction: Double) -> some View {
		VStack(spacing: .zero) {
			Spacer()
			ProgressView(value: progressFraction)
				.tint(.ypBlack)
			Spacer()
		}
	}

	private var errorImage: some View {
		Image(systemName: "exclamationmark.triangle.fill")
			.resizable()
			.scaledToFit()
			.foregroundStyle(.ypBlack)
	}

	private var nftDetails: some View {
		VStack(alignment: .leading, spacing: 4) {
			RatingView(model.rating)
			HStack(spacing: .zero) {
				VStack(alignment: .leading, spacing: 4) {
					Group {
						Text(model.name)
							.font(.system(size: 17, weight: .bold))
                            .minimumScaleFactor(0.5)
						Text("\(priceString) \(model.currency.rawValue.uppercased())")
							.font(.system(size: 10, weight: .medium))
					}
					.foregroundStyle(.ypBlack)
				}
				Spacer()
				Button(action: model.onCartTap) {
					Image(model.isAddedToCart ? .cartCross : .cart)
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
			isFavorite: true,
			isAddedToCart: true,
			onCartTap: { },
			onFavoriteTap: { }
		))
		NFTCardView(model: .init(
			name: "Test name",
			imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Ellsa/1.png"),
			rating: 0,
			price: 31,
			currency: .eth,
			isFavorite: false,
			isAddedToCart: false,
			onCartTap: { },
			onFavoriteTap: { }
		))
		NFTCardView(model: .init(
			name: "Test name",
			imageURL: URL(string: "https://code.s3.yande.net/Mobile/iOS/NFT/Beige/Ellsa/1.png"),
			rating: 0,
			price: 31.1,
			currency: .eth,
			isFavorite: false,
			isAddedToCart: false,
			onCartTap: { },
			onFavoriteTap: { }
		))
	}
}
