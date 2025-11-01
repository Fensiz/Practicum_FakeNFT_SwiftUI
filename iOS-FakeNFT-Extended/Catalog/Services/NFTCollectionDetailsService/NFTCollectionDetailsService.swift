//
//  NFTCollectionDetailsService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vladimir on 20.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import Foundation

protocol NFTCollectionDetailsServiceProtocol: Sendable {
	func fetchNFTs(collectionID: NFTCollectionCardModel.ID) async throws -> [NFTModel]
	func fetchAuthor(collectionID: NFTCollectionCardModel.ID) async throws -> NFTUserModel
	func updateCartStatus(nftID: NFTModel.ID) async throws
	func updateFavoriteStatus(nftID: NFTModel.ID) async throws
}

actor NFTCollectionDetailsService: NFTCollectionDetailsServiceProtocol {

	private let networkClient: any NetworkClient

	init(networkClient: any NetworkClient = DefaultNetworkClient()) {
		self.networkClient = networkClient
	}

	func fetchNFTs(collectionID: NFTCollectionCardModel.ID) async throws -> [NFTModel] {
		let collection = try await fetchCollection(id: collectionID)
		let nftIDs = collection.nftIDs
		let nftNetworkModels = try await withThrowingTaskGroup(
			of: NFTNetworkModel.self,
			returning: [NFTNetworkModel].self
		) { [weak self] group in
			guard let self else {
				return []
			}
			for nftID in nftIDs {
				group.addTask {
					let request = NFTByIDRequest(id: nftID)
					return try await self.networkClient.send(request: request)
				}
			}
			var result: [NFTNetworkModel] = []
			for try await nft in group {
				result.append(nft)
			}
			return result
		}
		return nftNetworkModels.map { NFTModel(networkModel: $0) }
	}

	func fetchAuthor(collectionID: NFTCollectionCardModel.ID) async throws -> NFTUserModel {
		let collection = try await fetchCollection(id: collectionID)
		let request = UserByIDRequest(id: UUID())
		let authorNetworkModel: NFTUserNetworkModel = try await networkClient.send(request: request)
		return NFTUserModel(networkModel: authorNetworkModel)
	}

	func updateCartStatus(nftID: NFTModel.ID) async throws {
		let orderGetRequest = OrdersRequest(httpMethod: .get, nftIDs: nil)
		let response: NFTOrderNetworkModel = try await networkClient.send(request: orderGetRequest)
		var nftIDs = response.nftIDs
		if nftIDs.contains(nftID) {
			nftIDs.removeAll(where: { $0 == nftID })
		} else {
			nftIDs.append(nftID)
		}
		let orderPutRequest = OrdersRequest(httpMethod: .put, nftIDs: nftIDs)
		_ = try await networkClient.send(request: orderPutRequest)
	}

	func updateFavoriteStatus(nftID: NFTModel.ID) async throws {
		let profileGetRequest = ProfileRequest(httpMethod: .get)
		print("fetching favourites")
		let profile: NFTProfileNetworkModel = try await networkClient.send(request: profileGetRequest)
		var likes = profile.likes
		if likes.contains(nftID) {
			likes.removeAll(where: { $0 == nftID })
		} else {
			likes.append(nftID)
		}
		let profilePutRequest = ProfileRequest(httpMethod: .put, likes: likes)
		print("updating favourites")
		_ = try await networkClient.send(request: profilePutRequest)
	}

	private func fetchCollection(id: NFTCollectionCardModel.ID) async throws -> NFTCollectionNetworkModel {
		let request = CollectionByIDRequest(id: id)
		let collection: NFTCollectionNetworkModel = try await networkClient.send(request: request)
		return collection
	}

}

actor NFTCollectionDetailsMockService: NFTCollectionDetailsServiceProtocol {

	private let throwsError: Bool

	private let mockNFTs: [NFTModel] = [
		.init(
			id: UUID(),
			authorID: UUID(),
			title: "Myrna Cervantes",
			imageURLs: [URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Ellsa/1.png")!],
			rating: 5,
			price: 39.37,
			currency: .eth
		),
		.init(
			id: UUID(),
			authorID: UUID(),
			title: "Melvin Yang",
			imageURLs: [URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Gray/Dominique/1.png")!],
			rating: 3,
			price: 8.04,
			currency: .eth
		),
		.init(
			id: UUID(),
			authorID: UUID(),
			title: "Sharon Paul",
			imageURLs: [URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Lucky/1.png")!],
			rating: 3,
			price: 27.32,
			currency: .eth
		),
		.init(
			id: UUID(),
			authorID: UUID(),
			title: "Mattie McDaniel",
			imageURLs: [URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Brown/Emma/1.png")!],
			rating: 1,
			price: 28.82,
			currency: .eth
		),
		.init(
			id: UUID(),
			authorID: UUID(),
			title: "Myrna Cervantes",
			imageURLs: [URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Ellsa/1.png")!],
			rating: 5,
			price: 39.37,
			currency: .eth
		),
		.init(
			id: UUID(),
			authorID: UUID(),
			title: "Melvin Yang",
			imageURLs: [URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Gray/Dominique/1.png")!],
			rating: 3,
			price: 8.04,
			currency: .eth
		),
		.init(
			id: UUID(),
			authorID: UUID(),
			title: "Sharon Paul",
			imageURLs: [URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Lucky/1.png")!],
			rating: 3,
			price: 27.32,
			currency: .eth
		),
		.init(
			id: UUID(),
			authorID: UUID(),
			title: "Mattie McDaniel",
			imageURLs: [URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Brown/Emma/1.png")!],
			rating: 1,
			price: 28.82,
			currency: .eth
		),
		.init(
			id: UUID(),
			authorID: UUID(),
			title: "Myrna Cervantes",
			imageURLs: [URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Ellsa/1.png")!],
			rating: 5,
			price: 39.37,
			currency: .eth
		),
		.init(
			id: UUID(),
			authorID: UUID(),
			title: "Melvin Yang",
			imageURLs: [URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Gray/Dominique/1.png")!],
			rating: 3,
			price: 8.04,
			currency: .eth
		),
		.init(
			id: UUID(),
			authorID: UUID(),
			title: "Sharon Paul",
			imageURLs: [URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Lucky/1.png")!],
			rating: 3,
			price: 27.32,
			currency: .eth
		),
		.init(
			id: UUID(),
			authorID: UUID(),
			title: "Mattie McDaniel",
			imageURLs: [URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Brown/Emma/1.png")!],
			rating: 1,
			price: 28.82,
			currency: .eth
		)
	]

	private let mockAuthor = NFTUserModel(
		id: UUID(),
		name: "Jimmie Reilly",
		description: "daddsd",
		nftIDs: [],
		websiteURL: URL(string: "https://apple.com")!,
		avatarURL: URL(string: "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/594.jpg")!
	)

	init(throwsError: Bool = false) {
		self.throwsError = throwsError
	}

	func fetchNFTs(collectionID: NFTCollectionCardModel.ID) async throws -> [NFTModel] {
		try? await Task.sleep(for: .seconds(3))
		if throwsError {
			throw NetworkClientError.urlSessionError
		} else {
			return mockNFTs
		}
	}

	func fetchAuthor(collectionID: NFTCollectionCardModel.ID) async throws -> NFTUserModel {
		try? await Task.sleep(for: .seconds(2))
		if throwsError {
			throw NetworkClientError.urlSessionError
		} else {
			return mockAuthor
		}
	}

	func updateCartStatus(nftID: NFTModel.ID) async throws {
		try? await Task.sleep(for: .seconds(1))
		if throwsError {
			throw NetworkClientError.urlSessionError
		}
	}

	func updateFavoriteStatus(nftID: NFTModel.ID) async throws {
		try? await Task.sleep(for: .seconds(1))
		if throwsError {
			throw NetworkClientError.urlSessionError
		}
	}

}
