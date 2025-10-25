//
//  CartItem.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 05.10.2025.
//

import SwiftUI

struct CartItem: Identifiable, Equatable, Hashable, Decodable {
	let id: String
	let image: URL
	let name: String
	let rating: Int
	let price: Double

	var priceText: String {
		"\(String(format: "%.2f", price)) ETH"
			.replacingOccurrences(of: ".", with: ",")
	}

	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}

	static let mock1 = CartItem(
		id: "qwkpwoqkp",
		image: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Pink/Calder/1.png")!,
		name: "aijoijdioajoid",
		rating: 2,
		price: 22.2
	)
}
