//
//  NFTUserNetworkModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vladimir on 31.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import Foundation

struct NFTUserNetworkModel: Identifiable, Decodable {

	let id: UUID
	let name: String
	let avatarURL: String
	let description: String
	let websiteURL: String
	let nftIDs: [NFTNetworkModel.ID]
	let rating: String

	enum CodingKeys: String, CodingKey {
		case id
		case name
		case avatarURL = "avatar"
		case description
		case websiteURL = "website"
		case nftIDs = "nfts"
		case rating
	}

}
