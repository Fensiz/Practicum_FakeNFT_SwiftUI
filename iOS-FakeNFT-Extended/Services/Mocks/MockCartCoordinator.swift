//
//  MockCartCoordinator.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 24.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

final class MockCartCoordinator: CartCoordinator {
	static let shared = MockCartCoordinator()

	func goBack() {

	}

	func openPayScreen(onSuccess: @escaping () async throws -> Void) {

	}

	func openSuccessPaymentScreen() {

	}

	func openUserAgreementScreen() {

	}

	func showDeleteConfirmation(
		for item: CartItem,
		deleteAction: @escaping () -> Void,
		cancelAction: @escaping () -> Void
	) {

	}
}
