//
//  NFTModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vladimir on 19.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import Foundation

struct NFTModel: Identifiable, Equatable {
	let id: UUID
	let authorID: NFTUserModel.ID
	let name: String
	let imageURL: URL
	let rating: Int
	let price: Double
	let currency: Currency
	var isFavourite: Bool = false
	var isAddedToCart: Bool = false
}
