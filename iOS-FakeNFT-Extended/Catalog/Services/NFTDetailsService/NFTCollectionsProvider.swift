//
//  NFTCollectionsProvider.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vladimir on 15.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import Foundation

protocol NFTCollectionsProviderProtocol: Sendable {
	func fetch(number: Int, sorting: CollectionsSortingType) async throws -> [NFTCollectionCardModel]
}

actor NFTCollectionsMockProvider: NFTCollectionsProviderProtocol {

	let throwsError: Bool

    private let nftCollections: [NFTCollectionCardModel] = [
		.init(
			id: UUID(uuidString: "d4fea6b6-91f1-45ce-9745-55431e69ef5c")!,
			title: "singulis epicuri",
			imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Обложки_коллекций/Brown.png")!,
			nftsCount: 4
		),
		.init(
			id: UUID(uuidString: "014a175d-c546-405c-8944-d694e4a1a47f")!,
			title: "Pink",
			imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Обложки_коллекций/Pink.png")!,
			nftsCount: 2
		),
		.init(
			id: UUID(uuidString: "81268b05-db02-4bc9-b0b0-f7136de49706")!,
			title: "unum reque",
			imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Обложки_коллекций/White.png")!,
			nftsCount: 2
		)
    ]

	init(throwsError: Bool = false) {
		self.throwsError = throwsError
	}

	func fetch(number: Int, sorting: CollectionsSortingType) async throws -> [NFTCollectionCardModel] {
        try? await Task.sleep(for: .seconds(3))
		if throwsError {
			throw NetworkClientError.urlSessionError
		} else {
			return (0..<number)
				.map { _ in nftCollections.randomElement()! }
				.sorted(by: sorting.sortingRule)
		}
    }

}
