//
//  NFTNetworkModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vladimir on 31.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import Foundation

struct NFTNetworkModel: Identifiable, Equatable, Decodable {

	let id: UUID
	let title: String
	let authorWebsiteURL: String
	let description: String
	let price: Double
	let rating: Int
	let imageURLs: [String]

	enum CodingKeys: String, CodingKey {
		case id
		case title = "name"
		case authorWebsiteURL = "author"
		case description
		case price
		case rating
		case imageURLs = "images"
	}

}
