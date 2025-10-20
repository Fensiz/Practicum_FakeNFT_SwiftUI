//
//  NFTCollectionDetailsService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vladimir on 20.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import Foundation

protocol NFTCollectionDetailsServiceProtocol: Sendable {
	func fetchNFTs() async throws -> [NFTModel]
	func fetchAuthor() async throws -> NFTUserModel
	func updateCartStatus(for nft: NFTModel) async throws
	func updateFavoriteStatus(for nft: NFTModel) async throws
}

actor NFTCollectionDetailsMockService: NFTCollectionDetailsServiceProtocol {

	private let throwsError: Bool

	private let mockNFTs: [NFTModel] = [
		.init(
			id: UUID(),
			authorID: UUID(),
			name: "Myrna Cervantes",
			imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Ellsa/1.png")!,
			rating: 5,
			price: 39.37,
			currency: .eth
		),
		.init(
			id: UUID(),
			authorID: UUID(),
			name: "Melvin Yang",
			imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Gray/Dominique/1.png")!,
			rating: 3,
			price: 8.04,
			currency: .eth
		),
		.init(
			id: UUID(),
			authorID: UUID(),
			name: "Sharon Paul",
			imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Lucky/1.png")!,
			rating: 3,
			price: 27.32,
			currency: .eth
		),
		.init(
			id: UUID(),
			authorID: UUID(),
			name: "Mattie McDaniel",
			imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Brown/Emma/1.png")!,
			rating: 1,
			price: 28.82,
			currency: .eth
		),
		.init(
			id: UUID(),
			authorID: UUID(),
			name: "Myrna Cervantes",
			imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Ellsa/1.png")!,
			rating: 5,
			price: 39.37,
			currency: .eth
		),
		.init(
			id: UUID(),
			authorID: UUID(),
			name: "Melvin Yang",
			imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Gray/Dominique/1.png")!,
			rating: 3,
			price: 8.04,
			currency: .eth
		),
		.init(
			id: UUID(),
			authorID: UUID(),
			name: "Sharon Paul",
			imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Lucky/1.png")!,
			rating: 3,
			price: 27.32,
			currency: .eth
		),
		.init(
			id: UUID(),
			authorID: UUID(),
			name: "Mattie McDaniel",
			imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Brown/Emma/1.png")!,
			rating: 1,
			price: 28.82,
			currency: .eth
		),
		.init(
			id: UUID(),
			authorID: UUID(),
			name: "Myrna Cervantes",
			imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Ellsa/1.png")!,
			rating: 5,
			price: 39.37,
			currency: .eth
		),
		.init(
			id: UUID(),
			authorID: UUID(),
			name: "Melvin Yang",
			imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Gray/Dominique/1.png")!,
			rating: 3,
			price: 8.04,
			currency: .eth
		),
		.init(
			id: UUID(),
			authorID: UUID(),
			name: "Sharon Paul",
			imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Lucky/1.png")!,
			rating: 3,
			price: 27.32,
			currency: .eth
		),
		.init(
			id: UUID(),
			authorID: UUID(),
			name: "Mattie McDaniel",
			imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Brown/Emma/1.png")!,
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
		websiteURL: URL(string: "https://student7.students.practicum.org")!,
		avatarURL: URL(string: "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/594.jpg")!
	)

	init(throwsError: Bool = false) {
		self.throwsError = throwsError
	}

	func fetchNFTs() async throws -> [NFTModel] {
		try? await Task.sleep(for: .seconds(3))
		if throwsError {
			throw NetworkClientError.urlSessionError
		} else {
			return mockNFTs
		}
	}

	func fetchAuthor() async throws -> NFTUserModel {
		try? await Task.sleep(for: .seconds(2))
		if throwsError {
			throw NetworkClientError.urlSessionError
		} else {
			return mockAuthor
		}
	}

	func updateCartStatus(for nft: NFTModel) async throws {
		try? await Task.sleep(for: .seconds(1))
		if throwsError {
			throw NetworkClientError.urlSessionError
		}
	}

	func updateFavoriteStatus(for nft: NFTModel) async throws {
		try? await Task.sleep(for: .seconds(1))
		if throwsError {
			throw NetworkClientError.urlSessionError
		}
	}

}
