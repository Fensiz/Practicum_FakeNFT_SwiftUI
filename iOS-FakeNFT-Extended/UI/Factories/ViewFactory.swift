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
	private let cartService: any CartService
	private let paymentService: any PaymentService
	private let cartViewModel: CartViewModel
	private let cartCoordinator: CartCoordinatorImpl

	// MARK: - Views

	private lazy var cartView: some View = CartView(viewModel: cartViewModel, coordinator: cartCoordinator)

	init(rootCoordinator: any RootCoordinator) {
		let networkService = DefaultNetworkClient()
		let storageService = NftStorageImpl()
		let nftService = NftServiceImpl(networkClient: networkService, storage: storageService)

		self.rootCoordinator = rootCoordinator
		self.cartService = CartServiceImpl(networkService: networkService, nftService: nftService)//MockCartServiceImpl()
		self.cartViewModel = CartViewModel(cartService: cartService)
		self.cartCoordinator = CartCoordinatorImpl(rootCoordinator: rootCoordinator)

		self.paymentService = PaymentServiceImpl(networkService: networkService)
	}

	// сюда добавляются все экраны, которые перекрывают tabView,
	// и относятся к navigationStack
	@ViewBuilder
	func makeScreenView(for screen: Screen) -> some View {
		switch screen {
			case .dummy:
				EmptyView()
			case let .payment(coordinartor, action):
				let viewModel = PaymentViewModel(paymentService: paymentService, onSuccess: action)
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
				cartView
			case .profile:
				EmptyView()
			case .statistic:
				EmptyView()
		}
	}
}
