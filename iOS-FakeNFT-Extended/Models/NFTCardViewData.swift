//
//  NFTCardViewData.swift
//  iOS-FakeNFT-Extended
//
//  Created by Алина on 02.11.2025.
//  Copyright © 2025 com.example. All rights reserved.
//
import Foundation

struct NFTCardModel {
	let name: String
	let imageURL: URL?
	let rating: Int
	let price: Double
	let currency: Currency
	let favorite: Bool
	let addedToCart: Bool
}
