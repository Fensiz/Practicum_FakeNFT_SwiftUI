//
//  NFTCollectionsService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Алина on 28.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//
import Foundation

protocol NFTItemCollectionService: Actor {
	func loadNft(id: String) async throws -> NFTItem
}

final actor NFTCollectionsServiceImpl: NFTItemCollectionService {
	private let networkClient: any NetworkClient

	init(networkClient: any NetworkClient) {
		self.networkClient = networkClient
	}

	func loadNft(id: String) async throws -> NFTItem {
		let request = NFTRequest(id: id)
		return try await networkClient.send(request: request)
	}
}
