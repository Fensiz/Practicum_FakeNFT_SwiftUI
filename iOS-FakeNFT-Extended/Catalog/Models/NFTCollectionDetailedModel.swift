//
//  NFTCollectionDetailedModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vladimir on 01.11.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import Foundation

struct NFTCollectionDetailedModel: Identifiable, Equatable {
	let id: NFTCollectionNetworkModel.ID
	let title: String
	let imageURL: URL?
	let nftIDs: [NFTModel.ID]
	let description: String
	let authorName: String
	let authorWebsite: URL?
}
