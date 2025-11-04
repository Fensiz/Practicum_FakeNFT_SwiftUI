//
//  API.swift
//  iOS-FakeNFT-Extended
//
//  Created by Алина on 27.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//
import Foundation

enum API {
	static let base = "/api/v1"
	/// Для работы с пользователями
	enum Users {
		/// Получить список всех пользователей
		static let list = "\(base)/users"
		/// Получить пользователя по ID
		/// - Parameter id: ID пользователя
		/// - Returns: Путь до конкретного пользователя
		static func byId(_ id: String) -> String { "\(base)/users/\(id)" }
	}
	enum NFT {
		static let list = "\(base)/nft"
		/// Получение NFT с заданным Id
		/// - Parameter id: ID NFT
		/// - Returns: Путь до конкретного NFT
		static func byId(_ id: String) -> String { "\(base)/nft/\(id)" }
	}
	/// Для работы с коллекциями NFT
	enum Collections {
		/// Получение списка коллекций
		static let list = "\(base)/collections"
		/// Получение коллекции с заданным id
		/// - Parameter id: ID коллекции с NFT
		/// - Returns: По до конкретной коллекции с NFT
		static func byId(_ id: String) -> String { "\(base)/collections/\(id)" }
	}
	
	/// Заказы/корзина
	enum Orders {
		/// Путь до конкретного заказа (по умолчанию — 1)
		static func byId(_ orderId: Int = 1) -> String { "\(base)/orders/\(orderId)" }
		/// Установка валюты перед оплатой
		static func payment(orderId: Int = 1, currencyId: Int) -> String {
			"\(base)/orders/\(orderId)/payment/\(currencyId)"
		}
	}
	
	enum Profile {
		/// Путь до профиля (по умолчанию — 1)
		static func byId(_ id: Int) -> String { "\(base)/profile/\(id)" }
		static func byId(_ id: String) -> String { "\(base)/profile/\(id)" }
	}
}
