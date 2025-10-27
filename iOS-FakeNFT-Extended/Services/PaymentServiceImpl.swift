//
//  PaymentServiceImpl.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 14.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

final actor PaymentServiceImpl: PaymentService {
	enum PaymentError: Error {
		case paymentFailed
	}

	private let networkService: any NetworkClient

	init(networkService: any NetworkClient) {
		self.networkService = networkService
	}

	func fetchPaymentMethods() async throws -> [PaymentMethod] {
		let request = CurrenciesRequest()
		let result: [PaymentMethod] = try await networkService.send(request: request)
		return result
	}

	func performPayment(with paymentMethod: PaymentMethod) async throws {
		let request = PaymentRequest(currencyId: paymentMethod.id)
		let result: PaymentResponse = try await networkService.send(request: request)
		guard result.success else {
			throw PaymentError.paymentFailed
		}
	}
}
