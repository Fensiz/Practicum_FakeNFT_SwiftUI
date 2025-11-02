//
//  FavoriteNFTCell.swift
//  iOS-FakeNFT-Extended
//
//  Created by Hajime4life on 15.10.2025.
//

import SwiftUI
import Kingfisher

struct MyNFTCell: View {
	let nft: NFT
	let isLiked: Bool
	let onLikeTap: () -> Void

	var body: some View {
		HStack(spacing: 0) {
			KFImage(nft.images.first)
				.resizable()
				.aspectRatio(contentMode: .fit)
				.frame(width: 108, height: 108)
				.cornerRadius(12)
				.aspectRatio(contentMode: .fit)
				.overlay(alignment: .topTrailing) {
					Button(action: onLikeTap) {
						Image(.active)
							.foregroundColor(isLiked ? .ypURed : .ypUWhite)
					}
				}
			VStack(alignment: .leading, spacing: 5) {
				Text(nft.name)
					.foregroundColor(.ypBlack)
					.font(Font(UIFont.bodyBold))
				RatingView(nft.rating)
				HStack(spacing: 4) {
					Text("ОТ")
						.foregroundColor(.ypBlack)
						.font(Font(UIFont.caption1))
					Text(nft.author.absoluteString)
						.foregroundColor(.ypBlack)
						.font(Font(UIFont.caption2))
				}
			}
			.padding(.leading, 20)
			Spacer()
			VStack(alignment: .leading, spacing: 2) {
				Text("Цена")
					.font(Font(UIFont.caption2))
				Text("\(String(format: "%.2f", nft.price)) ETH")
					.font(Font(UIFont.bodyBold))
			}
			.foregroundColor(.ypBlack)
		}
	}
}

#Preview {
	MyNFTCell(
		nft: .init(
			id: "asdkoapkdsaokd",
			name: "test",
			images: [URL(string: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Cardano_(ADA).png")!],
			rating: 3,
			description: "123",
			price: 2,
			author: URL(string: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Cardano_(ADA).png")!
		),
		isLiked: false,
		onLikeTap: {}
	)
}
