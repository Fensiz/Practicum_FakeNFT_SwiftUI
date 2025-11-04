//
//  UserByIDRequest.swift
//  iOS-FakeNFT-Extended
//
//  Created by Алина on 01.11.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import Foundation

struct UserByIDRequest: NetworkRequest, Sendable {
	let userID: String
	
	var endpoint: URL? {
		var comps = URLComponents(string: RequestConstants.baseURL)
		comps?.path = API.Users.byId(userID)
		return comps?.url
	}
}
