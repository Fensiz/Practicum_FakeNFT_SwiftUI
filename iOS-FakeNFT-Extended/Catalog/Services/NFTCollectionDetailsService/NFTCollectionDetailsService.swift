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

enum NFTCollectionDetailsServiceError: Error {
	case cartUpdateError
	case favoriteUpdateError
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
			for try await nft in group where !result.contains(nft) {
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
		let orderResponse: NFTOrderNetworkModel = try await networkClient.send(request: orderPutRequest)
		if orderResponse.nftIDs != nftIDs {
			throw NFTCollectionDetailsServiceError.cartUpdateError
		}
	}

	func updateFavoriteStatus(nftID: NFTModel.ID) async throws {
		var likes = try await fetchFavorites()
		if likes.contains(nftID) {
			likes.removeAll(where: { $0 == nftID })
		} else {
			likes.append(nftID)
		}
		let profilePutRequest = ProfileRequest(httpMethod: .put, likes: likes)
		let profileResponse: NFTProfileNetworkModel = try await networkClient.send(request: profilePutRequest)
		if profileResponse.likes != likes {
			throw NFTCollectionDetailsServiceError.favoriteUpdateError
		}
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
		let profile: NFTProfileNetworkModel = try await networkClient.send(request: profileGetRequest)
		return profile.likes
	}

	private func fetchCartStatus() async throws -> [NFTNetworkModel.ID] {
		let orderGetRequest = OrdersRequest(httpMethod: .get, nftIDs: nil)
		let response: NFTOrderNetworkModel = try await networkClient.send(request: orderGetRequest)
		return response.nftIDs
	}

}
