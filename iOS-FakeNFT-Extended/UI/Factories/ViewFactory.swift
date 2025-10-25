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
	private let profileViewModel: ProfileViewModel
	
	init(rootCoordinator: any RootCoordinator, profileViewModel: ProfileViewModel) {
		self.rootCoordinator = rootCoordinator
		self.profileViewModel = profileViewModel
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
		case .web:
			EmptyView()
		case .successPayment:
			EmptyView()
		case .myNfts:
			EmptyView()
			//            MyNFTList()
			//                .environmentObject(profileViewModel)
		case .favorites:
			EmptyView()
			//            FavoriteNFTsList()
			//                .environmentObject(profileViewModel)
		case .profileEdit:
			ProfileEditView(
				initialData: ProfileEditData(
					name: self.profileViewModel.editingUser?.name ?? "",
					description: self.profileViewModel.editingUser?.description ?? "",
					website: self.profileViewModel.editingUser?.website?.absoluteString ?? "",
					avatarURL: self.profileViewModel.editingUser?.avatar
				),
				onSave: { editedData in
					await self.profileViewModel.updateProfile(with: editedData)
				},
				onCancel: {
					self.profileViewModel.cancelEditing()
				},
				onDismiss: {
					self.rootCoordinator.goBack()
				},
				isSaving: self.profileViewModel.isSaveInProgress
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
			let profileCoordinator = ProfileCoordinatorImpl(
				rootCoordinator: rootCoordinator,
				profileViewModel: profileViewModel
			)
			ProfileView(coordinator: profileCoordinator)
				.environmentObject(profileViewModel)
		case .statistic:
			EmptyView()
		}
	}
}
