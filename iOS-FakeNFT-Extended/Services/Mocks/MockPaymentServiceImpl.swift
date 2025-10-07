//
//  MockPaymentServiceImpl.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 12.10.2025.
//

import Foundation

final actor MockPaymentServiceImpl: PaymentService {
	func fetchPaymentMethods() async throws -> [PaymentMethod] {
		// эмуляция задержки и подгрузки данных
		try await Task.sleep(for: .seconds(0.5))
		return [
			PaymentMethod(
				id: "0",
				title: "Shiba_Inu",
				name: "SHIB",
				image: URL(string: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Shiba_Inu_(SHIB).png")
			),
			PaymentMethod(
				id: "1",
				title: "Cardano",
				name: "ADA",
				image: URL(string: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Cardano_(ADA).png")
			),
			PaymentMethod(
				id: "2",
				title: "Tether",
				name: "USDT",
				image: URL(string: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Tether_(USDT).png")
			),
			PaymentMethod(
				id: "4",
				title: "Solana",
				name: "SOL",
				image: URL(string: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Solana_(SOL).png")
			)
		]
	}
	func performPayment() async throws {

	}
}
