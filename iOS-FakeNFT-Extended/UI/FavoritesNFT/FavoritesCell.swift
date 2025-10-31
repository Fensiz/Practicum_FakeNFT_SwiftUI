//
//  FavoritesCell.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 31.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import SwiftUI
import Kingfisher

struct FavoritesCell: View {
	let item: FavoriteItem?
	let action: () async -> Void
	@State private var isLoading = false

	var body: some View {
		HStack(spacing: 12) {
			if let item {
				KFImage(item.image)
					.placeholder {
						Color.gray.opacity(0.3)
					}
					.resizable()
					.scaledToFit()
					.frame(width: 80, height: 80)
					.cornerRadius(12)
					.overlay(alignment: .topTrailing) {
						Button {
							isLoading = true
							Task {
								await action()
								isLoading = false
							}
						} label: {
							Image(.active)
								.foregroundColor(.ypURed)
						}
						.offset(x: 5, y: -5)
						.disabled(isLoading)
					}
				VStack(alignment: .leading, spacing: 8) {
					VStack(alignment: .leading, spacing: 4) {
						Text(item.name)
							.foregroundColor(DesignSystem.Color.textPrimary)
							.font(DesignSystem.Font.bodyBold)
						RatingView(item.rating)
					}
					Text("\(item.priceString) ETH")
						.foregroundColor(DesignSystem.Color.textPrimary)
						.font(DesignSystem.Font.caption1)

				}
				.padding(.trailing, 12)
			} else {
				Color.ypLightGrey
					.shimmer()
					.clipShape(RoundedRectangle(cornerRadius: 12))
			}
		}
		.frame(height: 80)
		.frame(maxWidth: .infinity, alignment: .leading)
		.loading(isLoading)
	}
}

#Preview {
	let item = FavoriteItem(
		image: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Pink/Calder/1.png")!,
		name: "Test",
		rating: 3,
		price: 12.45
	)
	FavoritesCell(item: item, action: {})
		.border(.red)
	FavoritesCell(item: nil, action: {})
		.border(.red)
}
