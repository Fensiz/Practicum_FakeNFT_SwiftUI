//
//  NFTUserModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vladimir on 19.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import Foundation

struct NFTUserModel: Identifiable, Equatable {
	let id: UUID
	let name: String
	let description: String
	let nftIDs: [NFTModel.ID]
	let websiteURL: URL
	let avatarURL: URL
}
