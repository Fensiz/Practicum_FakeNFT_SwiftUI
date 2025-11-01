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
	func fetchCollection(collectionID: NFTCollectionCardModel.ID) async throws -> NFTCollectionDetailsModel
	func updateCartStatus(nftID: NFTModel.ID) async throws
	func updateFavoriteStatus(nftID: NFTModel.ID) async throws
}

actor NFTCollectionDetailsService: NFTCollectionDetailsServiceProtocol {

	private let networkClient: any NetworkClient

	init(networkClient: any NetworkClient = DefaultNetworkClient()) {
		self.networkClient = networkClient
	}

	func fetchNFTs(collectionID: NFTCollectionCardModel.ID) async throws -> [NFTModel] {
		let collection = try await fetchNetworkCollection(id: collectionID)
		let nftIDs = collection.nftIDs
		let nftNetworkModels = try await withThrowingTaskGroup(
			of: NFTNetworkModel.self,
			returning: [NFTNetworkModel].self
		) { [weak self] group in
			guard let self else {
				return []
			}
			for nftID in nftIDs {
				group.addTask { try await self.fetchNetworkNFT(id: nftID)}
			}
			var result: [NFTNetworkModel] = []
			for try await nft in group {
				result.append(nft)
			}
			return result
		}
		let favorites = try await fetchFavorites()
		let cart = try await fetchCartStatus()
		return nftNetworkModels.map {
			NFTModel(
				id: $0.id,
				title: $0.title,
				imageURLs: $0.imageURLs.compactMap { urlString in URL(string: urlString) },
				rating: $0.rating,
				price: $0.price,
				currency: .eth,
				isFavourite: favorites.contains($0.id),
				isAddedToCart: cart.contains($0.id)
			)
		}
	}

	func fetchCollection(collectionID: NFTCollectionCardModel.ID) async throws -> NFTCollectionDetailsModel {
		let networkCollection: NFTCollectionNetworkModel = try await fetchNetworkCollection(id: collectionID)
		let authorWebsite: URL?
		if let nftID = networkCollection.nftIDs.first {
			let networkNFT = try await fetchNetworkNFT(id: nftID)
			authorWebsite = URL(string: networkNFT.authorWebsiteURL)
		} else {
			authorWebsite = nil
		}
		return NFTCollectionDetailsModel(
			id: networkCollection.id,
			title: networkCollection.title,
			imageURL: URL(string: networkCollection.coverURL),
			nftIDs: networkCollection.nftIDs,
			description: networkCollection.description,
			authorName: networkCollection.authorName,
			authorWebsite: authorWebsite
		)
	}

	func updateCartStatus(nftID: NFTModel.ID) async throws {
		var nftIDs = try await fetchCartStatus()
		if nftIDs.contains(nftID) {
			nftIDs.removeAll(where: { $0 == nftID })
		} else {
			nftIDs.append(nftID)
		}
		let orderPutRequest = OrdersRequest(httpMethod: .put, nftIDs: nftIDs)
		_ = try await networkClient.send(request: orderPutRequest)
	}

	func updateFavoriteStatus(nftID: NFTModel.ID) async throws {
		var likes = try await fetchFavorites()
		if likes.contains(nftID) {
			likes.removeAll(where: { $0 == nftID })
		} else {
			likes.append(nftID)
		}
		let profilePutRequest = ProfileRequest(httpMethod: .put, likes: likes)
		print("updating favourites")
		_ = try await networkClient.send(request: profilePutRequest)
	}

	private func fetchNetworkCollection(id: NFTCollectionNetworkModel.ID) async throws -> NFTCollectionNetworkModel {
		let request = CollectionByIDRequest(id: id)
		return try await networkClient.send(request: request)
	}

	private func fetchNetworkNFT(id: NFTNetworkModel.ID) async throws -> NFTNetworkModel {
		let request = NFTByIDRequest(id: id)
		return try await self.networkClient.send(request: request)
	}

	private func fetchFavorites() async throws -> [NFTNetworkModel.ID] {
		let profileGetRequest = ProfileRequest(httpMethod: .get)
		print("fetching favourites")
		let profile: NFTProfileNetworkModel = try await networkClient.send(request: profileGetRequest)
		return profile.likes
	}

	private func fetchCartStatus() async throws -> [NFTNetworkModel.ID] {
		let orderGetRequest = OrdersRequest(httpMethod: .get, nftIDs: nil)
		let response: NFTOrderNetworkModel = try await networkClient.send(request: orderGetRequest)
		return response.nftIDs
	}

}

actor NFTCollectionDetailsMockService: NFTCollectionDetailsServiceProtocol {

	private let throwsError: Bool

	private let mockNFTs: [NFTModel] = [
		.init(
			id: UUID(),
			title: "Myrna Cervantes",
			imageURLs: [URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Ellsa/1.png")!],
			rating: 5,
			price: 39.37,
			currency: .eth
		),
		.init(
			id: UUID(),
			title: "Melvin Yang",
			imageURLs: [URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Gray/Dominique/1.png")!],
			rating: 3,
			price: 8.04,
			currency: .eth
		),
		.init(
			id: UUID(),
			title: "Sharon Paul",
			imageURLs: [URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Lucky/1.png")!],
			rating: 3,
			price: 27.32,
			currency: .eth
		),
		.init(
			id: UUID(),
			title: "Mattie McDaniel",
			imageURLs: [URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Brown/Emma/1.png")!],
			rating: 1,
			price: 28.82,
			currency: .eth
		),
		.init(
			id: UUID(),
			title: "Myrna Cervantes",
			imageURLs: [URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Ellsa/1.png")!],
			rating: 5,
			price: 39.37,
			currency: .eth
		),
		.init(
			id: UUID(),
			title: "Melvin Yang",
			imageURLs: [URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Gray/Dominique/1.png")!],
			rating: 3,
			price: 8.04,
			currency: .eth
		),
		.init(
			id: UUID(),
			title: "Sharon Paul",
			imageURLs: [URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Lucky/1.png")!],
			rating: 3,
			price: 27.32,
			currency: .eth
		),
		.init(
			id: UUID(),
			title: "Mattie McDaniel",
			imageURLs: [URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Brown/Emma/1.png")!],
			rating: 1,
			price: 28.82,
			currency: .eth
		),
		.init(
			id: UUID(),
			title: "Myrna Cervantes",
			imageURLs: [URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Ellsa/1.png")!],
			rating: 5,
			price: 39.37,
			currency: .eth
		),
		.init(
			id: UUID(),
			title: "Melvin Yang",
			imageURLs: [URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Gray/Dominique/1.png")!],
			rating: 3,
			price: 8.04,
			currency: .eth
		),
		.init(
			id: UUID(),
			title: "Sharon Paul",
			imageURLs: [URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Lucky/1.png")!],
			rating: 3,
			price: 27.32,
			currency: .eth
		),
		.init(
			id: UUID(),
			title: "Mattie McDaniel",
			imageURLs: [URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Brown/Emma/1.png")!],
			rating: 1,
			price: 28.82,
			currency: .eth
		)
	]

	private let collectionDetails = NFTCollectionDetailsModel(
		id: UUID(uuidString: "81268b05-db02-4bc9-b0b0-f7136de49706")!,
		title: "unum reque",
		imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Обложки_коллекций/White.png"),
		nftIDs: [
			UUID(uuidString: "e33e18d5-4fc2-466d-b651-028f78d771b8")!,
			UUID(uuidString: "82570704-14ac-4679-9436-050f4a32a8a0")!
		],
		description: "dictas singulis placerat interdum maximus referrentur partiendo explicari verear molestiae",
		authorName: "Darren Morris",
		authorWebsite: URL(string: "https://sharp_matsumoto.fakenfts.org/")
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

	func fetchCollection(collectionID: NFTCollectionCardModel.ID) async throws -> NFTCollectionDetailsModel {
		try? await Task.sleep(for: .seconds(3))
		if throwsError {
			throw NetworkClientError.urlSessionError
		} else {
			return collectionDetails
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
