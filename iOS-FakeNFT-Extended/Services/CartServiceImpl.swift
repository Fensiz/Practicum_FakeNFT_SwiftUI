//
//  CartServiceImpl.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 14.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import Foundation

actor CartServiceImpl: CartService {
	private let networkService: any NetworkClient
	private let nftService: any NftService

	init(networkService: any NetworkClient, nftService: any NftService) {
		self.networkService = networkService
		self.nftService = nftService
	}

	func fetchOrderItems() async throws -> [CartItem] {
		let request = OrdersRequest()
		let result: Order = try await networkService.send(request: request)

		var items: [CartItem] = []
		for id in result.nfts {
			let nft = try await nftService.loadNft(id: id)
			guard let imageUrl = nft.images.first else { continue }
			let cartItem = CartItem(
				id: nft.id,
				image: imageUrl,
				name: nft.name,
				rating: nft.rating,
				price: nft.price
			)
			items.append(cartItem)
		}
		return items
	}

	func updateOrder(with itemIds: [NftId]) async throws {
		let request = OrdersRequest(
			httpMethod: .put,
			dto: itemIds
		)

		_ = try await networkService.send(request: request)
	}
}
