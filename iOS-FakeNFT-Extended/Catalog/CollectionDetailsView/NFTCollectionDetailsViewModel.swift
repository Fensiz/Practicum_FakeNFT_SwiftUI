//
//  NFTCollectionDetailsViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vladimir on 19.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import SwiftUI

@Observable
@MainActor
final class NFTCollectionDetailsViewModel {

	let collection: NFTCollectionModel
	private(set) var author: NFTUserModel?
	private(set) var nfts: [NFTModel] = []
	private(set) var state: State = .empty

	private let collectionDetailsService: any NFTCollectionDetailsServiceProtocol

	init(
		collection: NFTCollectionModel,
		collectionDetailsService: any NFTCollectionDetailsServiceProtocol
	) {
		self.collection = collection
		self.collectionDetailsService = collectionDetailsService
		updateDetails()
	}

	func updateDetails() {
		Task {
			do {
				guard state != .loading else { return }
				state = .loading
				async let author = try collectionDetailsService.fetchAuthor(collectionID: collection.id)
				async let nfts = try collectionDetailsService.fetchNFTs(collectionID: collection.id)
				self.author = try await author
				self.nfts = try await nfts
				state = .loaded
			} catch {
				state = .error
			}
		}
	}

	func updateFavoriteState(for nft: NFTModel) {
		Task {
			do {
				guard state != .loading,
					  let index = nfts.firstIndex(where: { $0.id == nft.id })
				else {
					return
				}
				state = .loading
				try await collectionDetailsService.updateFavoriteStatus(nftID: nft.id)
				self.nfts[index].isFavourite.toggle()
				state = .loaded
			}
		}
	}

	func updateCartState(for nft: NFTModel) {
		Task {
			do {
				guard state != .loading,
					  let index = nfts.firstIndex(where: { $0.id == nft.id })
				else {
					return
				}
				state = .loading
				try await collectionDetailsService.updateFavoriteStatus(nftID: nft.id)
				nfts[index].isAddedToCart.toggle()
				state = .loaded
			}
		}
	}

}

extension NFTCollectionDetailsViewModel {
	enum State: Equatable {
		case empty, loading, error, loaded
	}
}
