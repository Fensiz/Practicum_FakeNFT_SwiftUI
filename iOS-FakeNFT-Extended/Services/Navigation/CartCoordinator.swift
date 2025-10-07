//
//  CartCoordinator.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 12.10.2025.
//

import SwiftUI

@MainActor
protocol CartCoordinator: AnyObject {
	func goBack()
	func openPayScreen(onSuccess: @escaping () -> Void)
	func openSuccessPaymentScreen()
	func openUserAgreementScreen()
	func showDeleteConfirmation(
		for item: CartItem,
		deleteAction: @escaping () -> Void,
		cancelAction: @escaping () -> Void
	)
}

@Observable
class CartCoordinatorImpl: CartCoordinator {
	let rootCoordinator: any RootCoordinator

	init(rootCoordinator: any RootCoordinator) {
		self.rootCoordinator = rootCoordinator
	}

	func openPayScreen(onSuccess: @escaping () -> Void) {
		rootCoordinator.open(screen: .payment(coordinator: self, action: onSuccess))
	}

	func openSuccessPaymentScreen() {
		rootCoordinator.open(
			screen: .successPayment(action: rootCoordinator.popToRoot)
		)
	}

	func openUserAgreementScreen() {
		guard let url = URL(string: "https://yandex.ru/legal/practicum_termsofuse") else { return }
		rootCoordinator.open(screen: .web(url: url))
	}

	func showDeleteConfirmation(
		for item: CartItem,
		deleteAction: @escaping () -> Void,
		cancelAction: @escaping () -> Void
	) {
		rootCoordinator.show(cover: .deleteConfirmation(
			item: item,
			deleteAction: deleteAction,
			cancelAction: cancelAction
		))
	}

	func goBack() {
		rootCoordinator.goBack()
	}
}
