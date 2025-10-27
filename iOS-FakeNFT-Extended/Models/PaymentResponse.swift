//
//  PaymentResponse.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 26.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

struct PaymentResponse: Decodable {
	let success: Bool
	let orderId: String
	let id: String
}
