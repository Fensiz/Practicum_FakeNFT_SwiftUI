//
//  ProfileRequest.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vladimir on 31.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import Foundation

struct ProfileRequestCatalog: NetworkRequest {

	let httpMethod: HttpMethod
	let dto: Data?
	let endpoint: URL?

	init(
		httpMethod: HttpMethod = .get,
		name: String? = nil,
		description: String? = nil,
		website: String? = nil,
		likes: [NFTNetworkModel.ID]? = nil,
	) {
		self.httpMethod = httpMethod
		var params: [String: String] = [:]
		if let name {
			params["name"] = name
		}
		if let description {
			params["description"] = description
		}
		if let website {
			params["website"] = website
		}
		if let likes {
			let likesAsString = likes.compactMap({ $0.uuidString.lowercased() })
			if likesAsString.isEmpty {
				params["likes"] = "null"
			} else {
				params["likes"] = likesAsString.joined(separator: ",")
			}
		}
		if !params.isEmpty {
			dto = params.percentEncoded()
		} else {
			dto = nil
		}
		endpoint = URL(string: "\(RequestConstants.baseURL)/api/v1/profile/1")
	}

}
