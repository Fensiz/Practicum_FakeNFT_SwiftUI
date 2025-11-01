//
//  UserByIDRequest.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vladimir on 31.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import Foundation

struct UserByIDRequest: NetworkRequest {

	private let id: NFTUserNetworkModel.ID

	init(id: NFTUserNetworkModel.ID) {
		self.id = id
	}

	var endpoint: URL? {
		URL(string: "\(RequestConstants.baseURL)/api/v1/users/\(id)")
	}
	
}
