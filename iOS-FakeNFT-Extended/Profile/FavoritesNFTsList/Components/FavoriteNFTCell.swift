//
//  FavoriteNFTCell.swift
//  iOS-FakeNFT-Extended
//
//  Created by Hajime4life on 18.10.2025.
//

import SwiftUI
import Kingfisher

struct FavoriteNFTCell: View {
	let nft: NFT
	let isToggling: Bool
	let onLikeTap: () -> Void
	var body: some View {
		HStack(spacing: 0) {
			KFImage(nft.images.first)
				.placeholder {
					Color.gray.opacity(0.3)
				}
				.resizable()
				.aspectRatio(contentMode: .fit)
				.frame(width: 80, height: 80)
				.cornerRadius(12)
				.aspectRatio(contentMode: .fit)
				.overlay(alignment: .topTrailing) {
					Button(action: onLikeTap) {
						Image(.active)
							.foregroundColor(.ypURed)
					}
					.offset(x: 5, y: -5)
					.disabled(isToggling)
				}
			VStack(alignment: .leading, spacing: 5) {
				Text(nft.name)
					.foregroundColor(.ypBlack)
					.font(DesignSystem.Font.bodyBold)
				RatingView(nft.rating)
				HStack(spacing: 4) {
					Text("\(String(format: "%.2f", nft.price)) ETH")
						.foregroundColor(.ypBlack)
						.font(DesignSystem.Font.caption1)
				}
			}
			.padding(.leading, 20)
		}
		.opacity(isToggling ? 0.6 : 1.0)
		.animation(.easeInOut(duration: 0.2), value: isToggling)
	}
}

#Preview {
	let item = FavoriteItem(
		image: URL(string: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Cardano_(ADA).png")!,
		name: "test",
		rating: 2,
		price: 2.3
	)
	FavoritesCell(item: item, action: {})
		.border(.red)
}
