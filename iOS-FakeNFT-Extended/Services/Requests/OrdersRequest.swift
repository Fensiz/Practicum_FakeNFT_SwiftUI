//
//  OrdersRequest.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 14.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import Foundation

struct OrdersRequest: NetworkRequest, Sendable {
	let httpMethod: HttpMethod
	let dto: Data?
	var endpoint: URL? {
		URL(string: "\(RequestConstants.baseURL)/api/v1/orders/1")
	}

	init(
		httpMethod: HttpMethod = .get,
		nfts: [String]? = nil
	) {
		self.httpMethod = httpMethod
		if let nfts {
			let params = nfts.isEmpty ? [:] : [
				"nfts": nfts.joined(separator: ",")
			]
			self.dto = params.percentEncoded()
		} else {
			self.dto = nil
		}
	}

	init(httpMethod: HttpMethod = .get, nftIDs: [NFTNetworkModel.ID]? = nil) {
		self.httpMethod = httpMethod
		if let nftIDs {
			let nfts = nftIDs.map { $0.uuidString.lowercased() }
			let params = nfts.isEmpty ? [:] : [
				"nfts": nfts.joined(separator: ",")
			]
			self.dto = params.percentEncoded()
		} else {
			self.dto = nil
		}
	}
}
