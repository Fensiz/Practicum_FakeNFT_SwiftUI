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
	private let catalogCoordinator: any CatalogCoordinatorProtocol
	private let nftCollectionsProvider: any NFTCollectionsProviderProtocol
	private let nftCollectionDetailsService: any NFTCollectionDetailsServiceProtocol

	private lazy var catalogMainViewModel: NFTCollectionsListViewModel = {
		NFTCollectionsListViewModel(collectionsProvider: nftCollectionsProvider)
	}()

	init(rootCoordinator: any RootCoordinator) {
		self.rootCoordinator = rootCoordinator
		self.catalogCoordinator = CatalogCoordinator(rootCoordinator: rootCoordinator)
		var networkClient = DefaultNetworkClient()
		self.nftCollectionsProvider = NFTCollectionsProvider(pageSize: 10, networkClient: networkClient)
		self.nftCollectionDetailsService = NFTCollectionDetailsService(networkClient: networkClient)
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
			WebView(url: url)
		case .successPayment:
			EmptyView()
		case .collectionDetails(collectionID: let collectionID):
			let viewModel = NFTCollectionDetailsViewModel(
				collectionID: collectionID,
				collectionDetailsService: nftCollectionDetailsService
			)
			NFTCollectionDetailsView(
				viewModel: viewModel,
				coordinator: catalogCoordinator
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
			NFTCollectionsListView(
				viewModel: catalogMainViewModel,
				coordinator: catalogCoordinator
			)
		case .cart:
			EmptyView()
		case .profile:
			EmptyView()
		case .statistic:
			EmptyView()
		}
	}
}
