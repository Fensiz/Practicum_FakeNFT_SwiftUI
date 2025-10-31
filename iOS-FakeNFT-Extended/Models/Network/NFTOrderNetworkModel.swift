//
//  NFTOrderNetworkModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vladimir on 31.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import Foundation

struct NFTOrderNetworkModel: Identifiable, Decodable {

	let id: UUID
	let nftIDs: [NFTNetworkModel.ID]

	enum CodingKeys: String, CodingKey {
		case id
		case nftIDs = "nfts"
	}

}
