//
//  FavoritesListViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 31.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import SwiftUI

@MainActor @Observable final class FavoritesListViewModel {
	private let nftService: any NftService
	private let unlikeAction: (String) async -> Void

	var nftIDs: [String]
	var nftCache: [String: NFT] = [:]

	init(
		nftService: any NftService,
		nftIDs: [String],
		unlikeAction: @escaping (String) async -> Void
	) {
		self.nftService = nftService
		self.nftIDs = nftIDs
		self.unlikeAction = unlikeAction
		for id in nftIDs {
			nftCache[id] = nil
		}
	}

	func loadNFTIfNeeded(for id: String) async {
		if nftCache[id] != nil { return }

		do {
			let nft = try await nftService.loadNft(id: id)
			nftCache[id] = nft
		} catch {
			print("Ошибка загрузки NFT \(id): \(error)")
		}
	}

	func unlike(nftID: String) async {
		await unlikeAction(nftID)
		nftIDs.removeAll { $0 == nftID }
		nftCache[nftID] = nil
	}
}
