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

    private let profileService: any ProfileService
    private let profileViewModel: ProfileViewModel
    private let profileCoordinator: ProfileCoordinatorImpl

	// MARK: - Views

	private lazy var cartView: some View = CartView(viewModel: cartViewModel, coordinator: cartCoordinator)
	private lazy var profileView: some View = ProfileView(
		viewModel: profileViewModel,
		coordinator: profileCoordinator
	)

	init(rootCoordinator: any RootCoordinator) {
		let networkService = DefaultNetworkClient()
		let context = SwiftDataStack.shared.container.mainContext
		let storageService = NftStorageSwiftDataImpl(context: context)
		let nftService = NftServiceImpl(networkClient: networkService, storage: storageService)

		self.rootCoordinator = rootCoordinator
		self.cartService = CartServiceImpl(networkService: networkService, nftService: nftService)
		self.cartViewModel = CartViewModel(cartService: cartService)
		self.cartCoordinator = CartCoordinatorImpl(rootCoordinator: rootCoordinator)

		self.paymentService = PaymentServiceImpl(networkService: networkService)

		self.profileService = ProfileServiceImpl(networkClient: networkClient)
        self.profileViewModel = ProfileViewModel(profileService: profileService, nftsService: nftService)
        self.profileCoordinator = ProfileCoordinatorImpl(rootCoordinator: rootCoordinator)
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
			case .web(let url):
				WebView(url: url, isAppearenceEnabled: true)
			case .successPayment(let action):
				SuccessPaymentScreen(action: action)
            case .myNfts:
                MyNFTList()
                    .environmentObject(profileViewModel)
            case .favorites:
                FavoriteNFTsList()
                    .environmentObject(profileViewModel)
            case .profileEdit:
                ProfileEditView(
                    initialData: ProfileEditData(
                        name: profileViewModel.editingUser?.name ?? "",
                        description: profileViewModel.editingUser?.description ?? "",
                        website: profileViewModel.editingUser?.website?.absoluteString ?? "",
                        avatarURL: profileViewModel.editingUser?.avatar
                    ),
                    onSave: { editedData in await self.profileViewModel.updateProfile(with: editedData) },
                    onCancel: { self.profileViewModel.cancelEditing() },
                    onDismiss: { self.rootCoordinator.goBack() },
                    isSaving: self.profileViewModel.isSaveInProgress,
                    errorMessage: self.profileViewModel.errorMessage
                )
            }
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
				profileView
			case .statistic:
				EmptyView()
		}
	}
}
