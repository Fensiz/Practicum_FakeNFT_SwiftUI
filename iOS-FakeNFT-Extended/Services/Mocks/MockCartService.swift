//
//  MockCartServiceImpl.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 12.10.2025.
//

import SwiftUI

final actor MockCartService: CartService {
	static let shared = MockCartService()

	var items: [CartItem] = [.mock1, .mock2]
	var isUpdateOrderCalled = false
	var updateOrderSendedItemIds: [NftId]?

	func fetchOrderItems() async throws -> [CartItem] {
		try await Task.sleep(for: .milliseconds(250))
		if Task.isCancelled {
			throw URLError(.cancelled)
		}
		print("OK")
		return items
	}

	func updateOrder(with items: [NftId]) async throws {
		updateOrderSendedItemIds = items
	}

	func setItems(_ items: [CartItem]) {
		self.items = items
	}
}
