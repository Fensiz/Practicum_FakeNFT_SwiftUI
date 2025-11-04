//
//  MockNetworkClient.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 26.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import Foundation

final actor MockNetworkClient: NetworkClient {
	var lastRequest: (any NetworkRequest)?
	var sendCalled = false
	var result: Any?

	func send<Response>(request: any NetworkRequest) async throws -> Response where Response: Decodable & Sendable {
		sendCalled = true
		lastRequest = request
		guard let result = result as? Response else {
			throw URLError(.badServerResponse)
		}
		print(2)
		return result
	}

	func setResult<T: Decodable>(_ result: T) async {
		self.result = result
	}
}
