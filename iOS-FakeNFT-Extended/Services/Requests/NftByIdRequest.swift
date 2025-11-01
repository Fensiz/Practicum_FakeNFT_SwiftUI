//
//  NFTByIDRequest.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vladimir on 31.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import Foundation

struct NFTByIDRequest: NetworkRequest {

	private let id: NFTNetworkModel.ID

	init(id: NFTNetworkModel.ID) {
		self.id = id
	}

	var endpoint: URL? {
		URL(string: "\(RequestConstants.baseURL)/api/v1/nft/\(id.uuidString.lowercased())")
	}

}
