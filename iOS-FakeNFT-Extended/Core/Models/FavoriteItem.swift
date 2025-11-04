//
//  FavoriteItem.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 31.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import Foundation

struct FavoriteItem {
	let image: URL
	let name: String
	let rating: Int
	let price: Double

	var priceString: String {
		String(format: "%.2f", price).replacingOccurrences(of: ".", with: ",")
	}
}
