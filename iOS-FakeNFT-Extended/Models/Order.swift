//
//  Order.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 14.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

struct Order: Decodable {
	let id: String
	let nfts: [String]
}
