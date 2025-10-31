//
//  NFTCollectionNetworkModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vladimir on 15.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import Foundation

struct NFTCollectionNetworkModel: Identifiable, Decodable {

    let id: UUID
    let title: String
    let createdAt: Date
    let coverURL: String
	let nftIDs: [NFTNetworkModel.ID]
    let description: String
	let authorID: NFTUserNetworkModel.ID

    enum CodingKeys: String, CodingKey {
        case id
        case title = "name"
        case createdAt
        case coverURL = "cover"
        case nftIDs = "nfts"
        case description
        case authorID = "author"
    }
	
}
