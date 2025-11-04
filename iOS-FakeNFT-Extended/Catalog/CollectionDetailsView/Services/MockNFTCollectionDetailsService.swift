//
//  NFTCollectionDetailsMockService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vladimir on 01.11.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import Foundation

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
