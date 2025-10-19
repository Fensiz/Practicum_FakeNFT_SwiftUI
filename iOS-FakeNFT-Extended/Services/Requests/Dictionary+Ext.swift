//
//  Dictionary+Ext.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 18.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import Foundation

extension Dictionary where Key == String, Value == String {
	/// Кодирует словарь в тело `application/x-www-form-urlencoded`
	func percentEncoded() -> Data? {
		let query = self.map { key, value in
			"\(key)=\(value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
		}
		.joined(separator: "&")
		return query.data(using: .utf8)
	}
}
