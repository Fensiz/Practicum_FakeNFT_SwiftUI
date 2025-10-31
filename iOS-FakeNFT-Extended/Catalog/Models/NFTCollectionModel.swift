//
//  CollectionCellModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vladimir on 15.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import Foundation

struct NFTCollectionModel: Identifiable, Equatable {
	let id: NFTCollectionNetworkModel.ID
	let title: String
    let imageURL: URL
	let nftIDs: [NFTModel.ID]
    let description: String
	let authorID: NFTUserModel.ID
}
