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
	private let nftService: any NftService

	private let profileService: any ProfileService
	private let profileViewModel: ProfileViewModel
	private let profileCoordinator: ProfileCoordinatorImpl
    private let statisticCoordinator: StatisticCoordinator

	// MARK: - Views

	private lazy var cartView: some View = CartView(
		viewModel: cartViewModel,
		coordinator: cartCoordinator
	)
	private lazy var profileView: some View = ProfileView(
		viewModel: profileViewModel,
		coordinator: profileCoordinator
	)

    private lazy var statisticView: some View = StatisticView()
        .environment(statisticCoordinator)

	init(rootCoordinator: any RootCoordinator) {
		let networkService = DefaultNetworkClient()
		let context = SwiftDataStack.shared.container.mainContext
		let storageService = NftStorageSwiftDataImpl(context: context)
		nftService = NftServiceImpl(networkClient: networkService, storage: storageService)

		self.rootCoordinator = rootCoordinator
		self.cartService = CartServiceImpl(networkService: networkService, nftService: nftService)
		self.cartViewModel = CartViewModel(cartService: cartService)
		self.cartCoordinator = CartCoordinatorImpl(rootCoordinator: rootCoordinator)

		self.paymentService = PaymentServiceImpl(networkService: networkService)

		self.profileService = ProfileServiceImpl(networkClient: networkService)
		self.profileViewModel = ProfileViewModel(profileService: profileService, nftsService: nftService)
		self.profileCoordinator = ProfileCoordinatorImpl(rootCoordinator: rootCoordinator)

        self.statisticCoordinator = StatisticCoordinator(rootCoordinator: rootCoordinator)
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
				PaymentView(viewModel: viewModel, coordinator: coordinartor)
			case let .web(url, isAppearenceEnabled):
				WebView(url: url, isAppearenceEnabled: isAppearenceEnabled)
			case .successPayment(let action):
				SuccessPaymentScreen(action: action)
			case .myNfts:
				MyNFTList(viewModel: profileViewModel)
			case let .favorites(ids, unlikeAction):
				let viewModel = FavoritesListViewModel(nftService: nftService, nftIDs: ids, unlikeAction: unlikeAction)
				FavoritesList(viewModel: viewModel, backAction: rootCoordinator.goBack)
			case let .profileEdit(profile, saveAction, closeAction):
				let viewModel = ProfileEditViewModel(profile: profile, saveAction: saveAction, closeAction: closeAction)
				ProfileEditView(viewModel: viewModel, coordinator: profileCoordinator)
			case .userCard(user: let user):
				UserCard(user: user)
                    .environment(statisticCoordinator)
			case .userCollection(let nftIDs):
				makeUserCollection(nftIDs: nftIDs)
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
			case let .urlEditAlert(url, title):
				UrlEditAlert(url: url, title: title, cancelAction: self.rootCoordinator.hideCover)
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
				profileView
			case .statistic:
				statisticView
		}
	}

	@ViewBuilder
	func makeUserCollection(nftIDs: [String]) -> some View {
		let userCollectionVM = UserCollectionViewModel(
			nftIDs: nftIDs,
			service: UserCollectionViewModel.Default.nftService,
			profileService: UserCollectionViewModel.Default.makeProfileService()
		)
		UserCollectionView(viewModel: userCollectionVM)
			.environment(statisticCoordinator)
	}
}
