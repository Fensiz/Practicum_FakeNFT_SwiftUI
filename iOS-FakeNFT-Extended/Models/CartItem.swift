//
//  CartItem.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 05.10.2025.
//

import SwiftUI

struct CartItem: Identifiable, Equatable, Hashable {
	let id: UUID = UUID()
	let image: Image
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
}
