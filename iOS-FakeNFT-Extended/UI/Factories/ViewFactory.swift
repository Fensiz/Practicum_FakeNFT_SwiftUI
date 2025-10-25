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
	private let profileService: any ProfileService
	private let profileViewModel: ProfileViewModel
	private let profileCoordinator: ProfileCoordinatorImpl
	private lazy var profileView: some View = ProfileView(
		viewModel: profileViewModel,
		coordinator: profileCoordinator
	)
	init(rootCoordinator: any RootCoordinator) {
		let networkClient = DefaultNetworkClient()
		let context = SwiftDataStack.shared.container.mainContext
		let storageService = NftStorageSwiftDataImpl(context: context)
		let nftService = NftServiceImpl(networkClient: networkClient, storage: storageService)
		let profileService = ProfileServiceImpl(networkClient: networkClient)
		self.rootCoordinator = rootCoordinator
		self.profileService = profileService
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
		case .payment:
			EmptyView()
		case .web(let url):
			WebView(url: url, isAppearenceEnabled: true)
		case .successPayment:
			EmptyView()
		case .myNfts:
			MyNFTList(viewModel: profileViewModel)
		case .favorites:
			EmptyView()
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
	// сюда вроде бы кроме корзины никто ничего не добавляет,
	// но мне эта заготовка нужна в корне проекта
	// в теории можно добавлять свои экраны, которые
	// накладываются сверху, а не через navigationStack
	@ViewBuilder
	func makeCoverView(for coverType: Cover) -> some View {
		switch coverType {
		case .dummy:
			EmptyView()
		case .deleteConfirmation:
			EmptyView()
		}
	}
	@ViewBuilder
	func makeTabView(for tab: Tab) -> some View {
		switch tab {
		case .catalog:
			TestCatalogView()
		case .cart:
			EmptyView()
		case .profile:
			profileView
		case .statistic:
			EmptyView()
		}
	}
}
