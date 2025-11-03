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

	private(set) var collections: [NFTCollectionCardModel] = []
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
		let guardCondition = isInitialFetch ? (state == .empty) : (state != .loading)
		Task {
			guard guardCondition else { return }
			do {
				state = .loading
				let newCollections = try await collectionsProvider.fetch(sorting: sortingType)
				collections.append(contentsOf: newCollections)
				collections.sort(by: sortingType.sortingRule)
				state = .loaded
			} catch {
				state = .error
			}
		}
	}

    func sort(by sortingType: CollectionsSortingType) {
		guard sortingType != self.sortingType else { return }
		self.sortingType = sortingType
		collections.sort(by: sortingType.sortingRule)
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
