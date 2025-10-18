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
	let onSuccess: () -> Void
	var isLoading = false
	var isAlertPresented = false
	var paymentMethods: [PaymentMethod] = []
	var selectedMethod: PaymentMethod?
	var isButtonDisabled: Bool {
		selectedMethod == nil || isLoading
	}
	private let paymentService: any PaymentService
	private var lastAction: (() -> Void)?

	init(paymentService: any PaymentService, onSuccess: @escaping () -> Void) {
		self.paymentService = paymentService
		self.onSuccess = onSuccess
	}

	func load() {
		isLoading = true
		Task {
			do {
				paymentMethods = try await paymentService.fetchPaymentMethods()
				isLoading = false
			} catch {
				print("Ошибка загрузки методов оплаты: \(error)")
				isLoading = false
				lastAction = load
				isAlertPresented = true
			}
		}
	}

	func pay(onSuccess: @escaping () -> Void) {
		Task {
			do {
				guard let selectedMethod else { return }
				try await paymentService.performPayment(for: "1", with: selectedMethod)
				lastAction = nil
				onSuccess()
			} catch {
				print(error.localizedDescription)
				lastAction = { [weak self] in
					self?.pay(onSuccess: onSuccess)
				}
				isAlertPresented = true
			}
		}
	}

	func repeatAction() {
		lastAction?()
		isAlertPresented = false
	}

	func select(_ method: PaymentMethod) {
		selectedMethod = method
	}
}
