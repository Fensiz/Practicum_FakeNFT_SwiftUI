//
//  NFTModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vladimir on 19.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import Foundation

struct NFTModel: Identifiable, Equatable {
	let id: NFTNetworkModel.ID
	let authorID: NFTUserModel.ID
	let title: String
	let imageURLs: [URL]
	let rating: Int
	let price: Double
	let currency: Currency
	var isFavourite: Bool = false
	var isAddedToCart: Bool = false
	var imageURL: URL? {
		imageURLs.first
	}
}

extension NFTModel {
	init(networkModel: NFTNetworkModel) {
		self.id = networkModel.id
		self.authorID = networkModel.id
		self.title = networkModel.title
		self.imageURLs = networkModel.imageURLs.compactMap { URL(string: $0) }
		self.rating = networkModel.rating
		self.price = networkModel.price
		self.currency = .eth
	}
}
