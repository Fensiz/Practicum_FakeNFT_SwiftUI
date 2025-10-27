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

	private var sortingType: CollectionsSortingType {
		get {
			let savedValue = UserDefaults.standard.integer(forKey: "CollectionsSortingKey")
			return .init(rawValue: savedValue) ?? .bySize
		}
		set {
			UserDefaults.standard.set(newValue.rawValue, forKey: "CollectionsSortingKey")
		}
	}

	func fetchCollections(isInitialFetch: Bool) {
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
				let newCollections = try await collectionsProvider.fetch(number: 10, sorting: sortingType)
				collections.append(contentsOf: newCollections)
				state = .loaded
			} catch {
				state = .error
			}
		}
	}

    func sort(by sortingType: CollectionsSortingType) {
		guard sortingType != self.sortingType else { return }
		state = .empty
		Task {
			guard state != .loading else { return }
			do {
				state = .loading
				collections = try await collectionsProvider.fetch(number: collections.count, sorting: sortingType)
				state = .loaded
			} catch {
				state = .error
			}
			self.sortingType = sortingType
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

enum CollectionsSortingType: Int, CaseIterable, Identifiable {

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

	var sortingRule: (NFTCollectionModel, NFTCollectionModel) -> Bool {
		switch self {
		case .byTitle:
			{ $0.title < $1.title }
		case .bySize:
			{ $0.nftIDs.count < $1.nftIDs.count }
		}
	}

}
