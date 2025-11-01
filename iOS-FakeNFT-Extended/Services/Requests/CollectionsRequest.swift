//
//  CollectionsRequest.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vladimir on 01.11.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import Foundation

struct CollectionsRequest: NetworkRequest {

	let endpoint: URL?

	init(page: Int, pageSize: Int) {
		self.endpoint = URL(string: "\(RequestConstants.baseURL)/api/v1/collections?page=\(page)&size=\(pageSize)")
	}

}
