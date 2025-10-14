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
	private var saveSuccessAction: (() -> Void)?
	private let paymentService: any PaymentService

	init(paymentService: any PaymentService, onSuccess: @escaping () -> Void) {
		self.paymentService = paymentService
		self.onSuccess = onSuccess
	}

	func load() async {
		isLoading = true
		do {
			paymentMethods = try await paymentService.fetchPaymentMethods()
		} catch {
			print("Ошибка загрузки методов оплаты: \(error)")
		}
		isLoading = false
	}

	func pay(onSuccess: @escaping () -> Void) {
		Task {
			do {
				try await paymentService.performPayment()
				saveSuccessAction = nil
				onSuccess()
			} catch {
				print(error.localizedDescription)
				saveSuccessAction = onSuccess
				isAlertPresented = true
			}
		}
	}

	func repeatAction() {
		guard let action = saveSuccessAction else { return }
		pay(onSuccess: action)
	}

	func select(_ method: PaymentMethod) {
		selectedMethod = method
	}
}
