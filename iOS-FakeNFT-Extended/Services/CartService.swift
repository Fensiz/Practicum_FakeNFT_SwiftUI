//
//  CartService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 12.10.2025.
//

protocol CartService: Actor {
	typealias NftId = String
	func fetchOrderItems() async throws -> [CartItem]
	func updateOrder(with itemIds: [NftId]) async throws
}
