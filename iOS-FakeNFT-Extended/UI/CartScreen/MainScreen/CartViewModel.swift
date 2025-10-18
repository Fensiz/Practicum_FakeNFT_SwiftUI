//
//  CartViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 12.10.2025.
//

import SwiftUI

@MainActor
@Observable
final class CartViewModel {
	enum SortType {
		case name, price, rating
	}
	var total: Double {
		items.map(\.price).reduce(0, +)
	}
	var items: [CartItem] = []
	var isLoading: Bool = false
	var isSortMenuShowing: Bool = false
	private let cartService: any CartService

	init(cartService: any CartService) {
		self.cartService = cartService
	}

	func showSortDialog() {
		isSortMenuShowing = true
	}

	func fetchItems() {
		isLoading = true
		Task {
			items = try await cartService.fetchOrderItems()
			isLoading = false
		}
	}
	func updateItems() {
		Task {
			try await cartService.updateOrder(with: items.map(\.id))
		}
	}

	func remove(_ item: CartItem) {
		items.removeAll { $0.id == item.id }
		print(items)
		updateItems()
	}

	func clearCart() {
		print("CLEAR CART")
		print(items)
		isLoading = true
		Task {
			try await cartService.updateOrder(with: [])
			items.removeAll()
			isLoading = false
		}
	}

	func isFirstItem(at index: Int) -> Bool {
		index == 0
	}

	func sort(by sortType: SortType) {
		switch sortType {
			case .name:
				items.sort(by: { $0.name < $1.name })
			case .price:
				items.sort(by: { $0.price < $1.price })
			case .rating:
				items.sort(by: { $0.rating < $1.rating })
		}
	}
}
