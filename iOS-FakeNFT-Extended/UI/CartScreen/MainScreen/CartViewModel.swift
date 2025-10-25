//
//  CartViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 12.10.2025.
//

import SwiftUI
import Observation

@MainActor @Observable final class CartViewModel {
	enum SortType: String, CaseIterable {
		case name, price, rating
	}

	var total: Double { items.map(\.price).reduce(0, +) }
	var items: [CartItem] = []
	var isLoading: Bool = false
	var isSortMenuShowing: Bool = false

	private let cartService: any CartService
	private static let sortTypeKey = "cart_sort_type"
	@ObservationIgnored private var currentSort: SortType {
		didSet {
			Self.saveSortType(currentSort)
		}
	}
	@ObservationIgnored private var fetchTask: Task<Void, any Error>?

	init(cartService: any CartService) {
		self.cartService = cartService
		self.currentSort = Self.loadSortType()
	}

	func showSortDialog() {
		isSortMenuShowing = true
	}

	func onAppear() {
		items = []
		isLoading = true
		fetchTask = Task {
			defer { isLoading = false }
			do {
				items = try await cartService.fetchOrderItems()
				sort(by: currentSort)
				fetchTask = nil
			} catch is CancellationError {
				print("Отмена загрузки корзины")
			} catch let urlError as URLError where urlError.code == .cancelled {
				print("Отмена загрузки корзины (URLError)")
			} catch {
				print("❌ Ошибка загрузки корзины:", error)
			}
		}
	}

	func onDisappear() {
		fetchTask?.cancel()
		fetchTask = nil
		isLoading = false
	}

	func updateItems() {
		Task {
			try await cartService.updateOrder(with: items.map(\.id))
		}
	}

	func remove(_ item: CartItem) {
		items.removeAll { $0.id == item.id }
		updateItems()
	}

	func clearCart() async throws {
		try await cartService.updateOrder(with: [])
	}

	func sort(by sortType: SortType) {
		currentSort = sortType
		switch sortType {
			case .name:
				items.sort(by: { $0.name < $1.name })
			case .price:
				items.sort(by: { $0.price < $1.price })
			case .rating:
				items.sort(by: { $0.rating > $1.rating })
		}
	}

	private static func saveSortType(_ sortType: SortType) {
		UserDefaults.standard.set(sortType.rawValue, forKey: sortTypeKey)
	}

	private static func loadSortType() -> SortType {
		if let rawValue = UserDefaults.standard.string(forKey: sortTypeKey),
		   let type = SortType(rawValue: rawValue) {
			return type
		}
		return .name
	}
}
