//
//  NFTCollectionsListViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vladimir on 15.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import SwiftUI

@Observable
@MainActor
final class NFTCollectionsListViewModel {

	private(set) var collections: [NFTCollectionModel] = []
	private(set) var state: State = .empty

	private let collectionsProvider: any NFTCollectionsProviderProtocol

	func fetchCollections(isInitialFetch: Bool = false) {
		let guardCondition: Bool
		if isInitialFetch {
			guardCondition = (state == .empty)
		} else {
			guardCondition = (state != .loading)
		}
		Task {
			guard guardCondition else { return }
			do {
				state = .loading
				let newCollections = try await collectionsProvider.fetch(number: 10)
				collections.append(contentsOf: newCollections)
				state = .loaded
			} catch {
				state = .error
			}
		}
	}

    func sort(by sortingArg: CatalogSorting) {
        switch sortingArg {
        case .byTitle:
            collections.sort(by: { $0.title < $1.title })
        case .bySize:
            collections.sort(by: { $0.nftIDs.count < $1.nftIDs.count })
        }
    }

	init(collectionsProvider: any NFTCollectionsProviderProtocol) {
        self.collectionsProvider = collectionsProvider
    }

}

extension NFTCollectionsListViewModel {
    enum State: Equatable {
        case empty
        case loading
        case error
        case loaded
    }
}

enum CatalogSorting: Int, CaseIterable, Identifiable {

    var id: Self { self }

    case byTitle
    case bySize

    var description: String {
        switch self {
        case .byTitle:
            NSLocalizedString("Catalog.Sorting.ByTitle", comment: "")
        case .bySize:
            NSLocalizedString("Catalog.Sorting.BySize", comment: "")
        }
    }

}
