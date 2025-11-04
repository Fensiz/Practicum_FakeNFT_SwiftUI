//
//  CollectionByIDRequest.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vladimir on 31.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import Foundation

struct CollectionByIDRequest: NetworkRequest {

	private let id: NFTCollectionNetworkModel.ID

	var endpoint: URL? {
		URL(string: "\(RequestConstants.baseURL)/api/v1/collections/\(id.uuidString.lowercased())")
	}

	init(id: NFTCollectionNetworkModel.ID) {
		self.id = id
	}

}
