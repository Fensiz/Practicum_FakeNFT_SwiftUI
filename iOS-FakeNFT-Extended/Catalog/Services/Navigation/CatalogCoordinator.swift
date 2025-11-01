//
//  CatalogCoordinator.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vladimir on 20.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import Foundation

@MainActor
protocol CatalogCoordinatorProtocol {
	func goBack()
	func showDetails(for collection: NFTCollectionCardModel)
	func showWebView(for url: URL)
}

final class CatalogCoordinator: CatalogCoordinatorProtocol {

	private let rootCoordinator: any RootCoordinator

	init(rootCoordinator: any RootCoordinator) {
		self.rootCoordinator = rootCoordinator
	}

	func goBack() {
		rootCoordinator.goBack()
	}

	func showDetails(for collection: NFTCollectionCardModel) {
		rootCoordinator.open(screen: .collectionDetails(collection: collection))
	}

	func showWebView(for url: URL) {
		rootCoordinator.open(screen: .web(url: url))
	}

}
