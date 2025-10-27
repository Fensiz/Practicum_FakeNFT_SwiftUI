//
//  FavoriteNFTCell.swift
//  iOS-FakeNFT-Extended
//
//  Created by Hajime4life on 15.10.2025.
//

import SwiftUI
import Kingfisher

struct MyNFTCell: View {
	let nft: NFTEntity
	let author: String?
	let isLiked: Bool
	let onLikeTap: () -> Void
	var body: some View {
		HStack(spacing: 0) {
			KFImage(nft.imageURLs.first)
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
					Text("\(author == nil ? "Не указано" : author!)")
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
