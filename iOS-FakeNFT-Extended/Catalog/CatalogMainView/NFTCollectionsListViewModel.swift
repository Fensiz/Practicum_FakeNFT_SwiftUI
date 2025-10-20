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

	private let collectionsProvider: any NFTCollectionsProviderProtocol
	private let coordinator: any CatalogCoordinatorProtocol

    private(set) var collections: [NFTCollectionModel] = []
	private(set) var hasError = false
	private(set) var state: State = .empty {
		didSet {
			hasError = false
			UIBlockingProgressHUD.dismiss()
			switch state {
			case .empty:
				break
			case .loading:
				if oldValue == .empty {
					UIBlockingProgressHUD.show()
				}
			case .error:
				hasError = true
			case .loaded:
				break
			}
		}
	}

    func fetchNewCollections() {
		Task {
			guard state != .loading else { return }
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

	func fetchInitialCollections() {
		Task {
			guard state == .empty else { return }
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

	func collectionTapped(_ collection: NFTCollectionModel) {
		coordinator.showDetails(for: collection, coordinator: coordinator)
	}

	init(
		collectionsProvider: any NFTCollectionsProviderProtocol,
		coordinator: any CatalogCoordinatorProtocol
	) {
        self.collectionsProvider = collectionsProvider
		self.coordinator = coordinator

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
