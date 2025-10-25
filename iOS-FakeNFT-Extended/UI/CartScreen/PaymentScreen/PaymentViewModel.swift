//
//  PaymentViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 12.10.2025.
//

import SwiftUI

@MainActor
@Observable
final class PaymentViewModel {
	let onSuccess: () async throws -> Void
	var isLoading = false
	var isAlertPresented = false
	var paymentMethods: [PaymentMethod] = []
	var selectedMethod: PaymentMethod?
	var isButtonDisabled: Bool {
		selectedMethod == nil || isLoading
	}
	private let paymentService: any PaymentService
	private var lastAction: (() -> Void)?

	init(paymentService: any PaymentService, onSuccess: @escaping () async throws -> Void) {
		self.paymentService = paymentService
		self.onSuccess = onSuccess
	}

	func load() {
		guard paymentMethods.isEmpty else { return }
		isLoading = true
		print(isLoading)
		Task {
			try? await Task.sleep(for: .seconds(3))

			do {
				paymentMethods = try await paymentService.fetchPaymentMethods()
				isLoading = false
			} catch {
				print("Ошибка загрузки методов оплаты: \(error.localizedDescription)")
				isLoading = false
				lastAction = load
				isAlertPresented = true
			}
		}
	}

	private var paymentSucceeded = false

	func pay(onSuccess: @escaping () -> Void) {
		isLoading = true
		Task {
			do {
				guard let selectedMethod else { return }
				if !paymentSucceeded {
					try await paymentService.performPayment(with: selectedMethod)
					paymentSucceeded = true
				}
				try await self.onSuccess()
				lastAction = nil
				isLoading = false
				paymentSucceeded = false
				onSuccess()
			} catch {
				print("Ошибка оплаты:", error.localizedDescription)
				lastAction = { [weak self, onSuccess] in
					self?.pay(onSuccess: onSuccess)
				}
				isAlertPresented = true
			}
		}
	}

	func repeatAction() {
		isAlertPresented = false
		lastAction?()
	}

	func select(_ method: PaymentMethod) {
		selectedMethod = method
	}
}
