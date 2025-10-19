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

    private(set) var state: State = .empty
    private(set) var collections: [NFTCollectionModel] = []

    private let collectionsProvider: any NFTCollectionsProviderProtocol

    func fetchNewCollections(number: Int) async {
        guard state != .loading else { return }
        do {
            state = .loading
            let newCollections = try await collectionsProvider.fetch(number: number)
            state = .loaded
            collections.append(contentsOf: newCollections)
        } catch {
            state = .error
        }
    }

    func sort(by sortingArg: CatalogSorting) {
        switch sortingArg {
        case .byTitle:
            collections.sort(by: { $0.title < $1.title })
        case .bySize:
            collections.sort(by: { $0.nfts.count < $1.nfts.count })
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

enum CatalogSorting: CaseIterable, Identifiable {

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
