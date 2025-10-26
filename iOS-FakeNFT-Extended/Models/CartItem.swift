//
//  CartItem.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 05.10.2025.
//

import SwiftUI

struct CartItem: Identifiable, Equatable, Hashable, Decodable {
	let id: String
	let image: URL?
	let name: String
	let rating: Int
	let price: Double

	var priceText: String {
		"\(String(format: "%.2f", price)) ETH"
			.replacingOccurrences(of: ".", with: ",")
	}

	init(
		id: String,
		image: URL? = URL(string: ""),
		name: String,
		rating: Int = 0,
		price: Double = 0
	) {
		self.id = id
		self.image = image
		self.name = name
		self.rating = rating
		self.price = price
	}

	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
}
