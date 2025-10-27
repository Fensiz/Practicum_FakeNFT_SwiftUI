//
//  MockNftService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 26.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import Foundation

final actor MockNftService: NftService {
	var loadedIds: [String] = []
	var mockNfts: [String: NFT] = [:]

	func loadNft(id: String) async throws -> NFT {
		loadedIds.append(id)
		if let nft = mockNfts[id] {
			return nft
		}
		throw URLError(.fileDoesNotExist)
	}

	func setNfts(_ nfts: [String: NFT]) async {
		self.mockNfts = nfts
	}
}
