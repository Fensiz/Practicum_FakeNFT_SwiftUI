//
//  CollectionCellModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vladimir on 15.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import Foundation

struct NFTCollectionModel: Identifiable, Equatable {
	let id: UUID
	let title: String
    let imageURL: URL
    let nfts: [NFTModel]
    let description: String
    let author: NFTUserModel
}
