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
