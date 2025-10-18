//
//  PaymentService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 12.10.2025.
//

protocol PaymentService: Actor {
	typealias UserId = String
	func fetchPaymentMethods() async throws -> [PaymentMethod]
	func performPayment(with paymentMethod: PaymentMethod) async throws
}
