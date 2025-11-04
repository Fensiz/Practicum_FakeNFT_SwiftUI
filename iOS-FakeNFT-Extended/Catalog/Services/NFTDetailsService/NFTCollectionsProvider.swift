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
				nftsCount: Set($0.nftIDs).count
			)
		}
	}

}
