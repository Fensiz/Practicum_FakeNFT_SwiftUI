//
//  NFTCollectionsProvider.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vladimir on 15.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import Foundation

protocol NFTCollectionsProviderProtocol: Sendable {
	func fetch(sorting: CollectionsSortingType) async throws -> [NFTCollectionCardModel]
}

actor NFTCollectionsProvider: NFTCollectionsProviderProtocol {

	private var currentPage = 0
	private let pageSize: Int

	private let networkClient: any NetworkClient

	init(pageSize: Int = 10, networkClient: any NetworkClient = DefaultNetworkClient()) {
		self.pageSize = pageSize
		self.networkClient = networkClient
	}

	func fetch(sorting: CollectionsSortingType) async throws -> [NFTCollectionCardModel] {
		let request = CollectionsRequest(page: currentPage, pageSize: pageSize)
		let networkCollections: [NFTCollectionNetworkModel] = try await networkClient.send(request: request)
		currentPage += 1
		return networkCollections.map {
			NFTCollectionCardModel(
				id: $0.id,
				title: $0.title,
				imageURL: URL(string: $0.coverURL),
				nftsCount: $0.nftIDs.count
			)
		}
	}

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
			id: UUID(uuidString: "49a96d73-d58f-4c01-8ce3-7d6949c980ca")!,
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

	func fetch(sorting: CollectionsSortingType) async throws -> [NFTCollectionCardModel] {
        try? await Task.sleep(for: .seconds(3))
		if throwsError {
			throw NetworkClientError.urlSessionError
		} else {
			return (0..<10)
				.map { _ in nftCollections.randomElement()! }
				.sorted(by: sorting.sortingRule)
		}
    }

}
