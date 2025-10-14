//
//  ViewFactory.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 09.10.2025.
//

import SwiftUI

@MainActor
final class ViewFactory {
	private let rootCoordinator: any RootCoordinator

	init(rootCoordinator: any RootCoordinator) {
		self.rootCoordinator = rootCoordinator
	}

	// сюда добавляются все экраны, которые перекрывают tabView,
	// и относятся к navigationStack
	@ViewBuilder
	func makeScreenView(for screen: Screen) -> some View {
		switch screen {
			case .dummy:
				EmptyView()
			case let .payment(coordinartor, action):
				let service = MockPaymentServiceImpl()
				let viewModel = PaymentViewModel(paymentService: service, onSuccess: action)
				PaymentView(coordinator: coordinartor, viewModel: viewModel)
			case .web(let url):
				WebView(url: url, isAppearenceEnabled: true)
			case .successPayment(let action):
				SuccessPaymentScreen(action: action)
		}
	}

	// сюда вроде бы кроме корзины никто ничего не добавляет,
	// но мне эта заготовка нужна в корне проекта
	// в теории можно добавлять свои экраны, которые
	// накладываются сверху, а не через navigationStack
	@ViewBuilder
	func makeCoverView(for coverType: Cover) -> some View {
		switch coverType {
			case .dummy:
				EmptyView()
			case let .deleteConfirmation(item, onDelete, onCancel):
				DeleteConfirmationView(item: item) {
					onDelete()
					self.rootCoordinator.hideCover()
				} cancelAction: {
					onCancel()
					self.rootCoordinator.hideCover()
				}
		}
	}

	@ViewBuilder
	func makeTabView(for tab: Tab) -> some View {
		switch tab {
			case .catalog:
				TestCatalogView()
			case .cart:
				let cartService = MockCartServiceImpl()
				let viewModel = CartViewModel(cartService: cartService)
				let cartCoordinator = CartCoordinatorImpl(rootCoordinator: rootCoordinator)
				CartView(viewModel: viewModel, coordinator: cartCoordinator)
			case .profile:
				EmptyView()
			case .statistic:
				EmptyView()
		}
	}
}
