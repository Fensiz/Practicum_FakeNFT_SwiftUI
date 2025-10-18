//
//  PaymentServiceImpl.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 14.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

actor PaymentServiceImpl: PaymentService {

	private let networkService: any NetworkClient

	init(networkService: any NetworkClient) {
		self.networkService = networkService
	}

	func fetchPaymentMethods() async throws -> [PaymentMethod] {
		let request = CurrenciesRequest()
		let result: [PaymentMethod] = try await networkService.send(request: request)
		return result
	}

	func performPayment(for userId: UserId, with paymentMethod: PaymentMethod) async throws {
		let request = PaymentRequest(userId: userId, currencyId: paymentMethod.id)
		_ = try await networkService.send(request: request)
	}
}
