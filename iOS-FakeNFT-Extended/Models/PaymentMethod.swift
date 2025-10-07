//
//  PaymentMethod.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 12.10.2025.
//

import Foundation

struct PaymentMethod: Identifiable, Decodable, Equatable {
	let id: String
	let title: String
	let name: String
	let image: URL?
}
