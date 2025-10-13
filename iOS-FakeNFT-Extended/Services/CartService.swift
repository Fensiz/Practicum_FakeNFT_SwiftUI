//
//  CartService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 12.10.2025.
//

protocol CartService {
	func fetchItems() -> [CartItem]
	func add(_ item: CartItem)
	func remove(_ item: CartItem)
	func clearCart()
}
