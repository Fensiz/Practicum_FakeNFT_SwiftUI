//
//  MockCartServiceImpl.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 12.10.2025.
//

import SwiftUI

actor MockCartServiceImpl: CartService {
	func fetchOrderItems() async throws -> [CartItem] {
		print("fetch")
		return items
	}

	func updateOrder(with items: [NftId]) async throws {

	}

	var items =
		[
			CartItem(
				id: "1",
				image: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Pink/Calder/1.png")!,
				name: "Edmund Flowers",
				rating: 1,
				price: 21.27
			),
			CartItem(
				id: "2",
				image: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Pink/Calder/1.png")!,
				name: "Edmund Flowers",
				rating: 3,
				price: 21.27
			)
		]
}
