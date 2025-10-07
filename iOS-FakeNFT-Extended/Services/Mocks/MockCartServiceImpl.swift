//
//  MockCartServiceImpl.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 12.10.2025.
//

import SwiftUI

class MockCartServiceImpl: CartService {
	var items = (1...10).map { _ in
		CartItem(
			image: Image(.mock1),
			name: "April",
			rating: 3,
			price: 1.78
		)
	}

	func add(_ item: CartItem) {
	}

	func fetchItems() -> [CartItem] {
		items
	}

	func remove(_ item: CartItem) {
		items.removeAll(where: { $0.id == item.id })
	}

	func clearCart() {
		items = []
	}
}
