//
//  NFTCardViewData.swift
//  iOS-FakeNFT-Extended
//
//  Created by Алина on 02.11.2025.
//  Copyright © 2025 com.example. All rights reserved.
//
import Foundation

struct NFTCardViewModel {
	let name: String
	let imageURL: URL?
	let rating: Int
	let price: Double
	let currency: Currency
	let isFavorite: Bool
	let isAddedToCart: Bool
	let onCartTap: () -> Void
	let onFavoriteTap: () -> Void
}
