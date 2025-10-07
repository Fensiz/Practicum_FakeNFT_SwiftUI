//
//  CartViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 12.10.2025.
//

import SwiftUI

@Observable
final class CartViewModel {
	enum SortType {
		case name, price, rating
	}
	var total: Double {
		items.map(\.price).reduce(0, +)
	}
	var items: [CartItem] = []
	var isSortMenuShowing: Bool = false
	private let cartService: any CartService

	init(cartService: any CartService) {
		self.cartService = cartService
	}

	func showSortDialog() {
		isSortMenuShowing = true
	}

	func updateItems() {
		items = cartService.fetchItems()
	}

	func remove(_ item: CartItem) {
		cartService.remove(item)
		updateItems()
	}

	func clearCart() {
		cartService.clearCart()
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
