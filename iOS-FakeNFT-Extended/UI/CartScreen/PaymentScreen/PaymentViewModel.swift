//
//  PaymentViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 12.10.2025.
//

import SwiftUI

@MainActor @Observable final class PaymentViewModel {
	var isAlertPresented = false
	var isButtonDisabled: Bool {
		selectedMethod == nil || isLoading
	}
	private(set) var paymentMethods: [PaymentMethod] = []
	private(set) var selectedMethod: PaymentMethod?
	private(set) var isLoading = false
	private(set) var error: AppError?
	private let onSuccess: () async throws -> Void
	private let paymentService: any PaymentService
	private var paymentSucceeded = false

	init(paymentService: any PaymentService, onSuccess: @escaping () async throws -> Void) {
		self.paymentService = paymentService
		self.onSuccess = onSuccess
	}

	func load() {
		guard paymentMethods.isEmpty else { return }
		isLoading = true
		Task {
			do {
				paymentMethods = try await paymentService.fetchPaymentMethods()
				isLoading = false
			} catch {
				print("Ошибка загрузки методов оплаты: \(error.localizedDescription)")
				isLoading = false
				self.error = AppError.of(
					type: .paymentMethodsRecieve(
						action: { [weak self] in self?.load() },
						dismiss: { [weak self] in self?.removeError() }
					)
				)
			}
		}
	}

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
				isLoading = false
				paymentSucceeded = false
				onSuccess()
			} catch {
				print("Ошибка оплаты:", error.localizedDescription)
				isLoading = false
				self.error = AppError.of(
					type: .payment(
						action: { [weak self] in self?.pay(onSuccess: onSuccess) },
						dismiss: { [weak self] in self?.removeError() }
					)
				)
			}
		}
	}

	func select(_ method: PaymentMethod) {
		selectedMethod = method
	}

	private func removeError() {
		error = nil
	}
}
