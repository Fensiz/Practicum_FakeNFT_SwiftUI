//
//  UsersRequest.swift
//  iOS-FakeNFT-Extended
//
//  Created by Алина on 26.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//
import Foundation

struct UsersRequest: NetworkRequest, Sendable {
	let page: Int
	let size: Int
	let sortBy: String?
	
	init(page: Int = 0, size: Int = 7, sortBy: String? = nil) {
		self.page = page
		self.size = size
		self.sortBy = sortBy
	}
	
	var endpoint: URL? {
		var comps = URLComponents(string: RequestConstants.baseURL)
		comps?.path = API.Users.list
		
		var queryItems = [
			URLQueryItem(name: "page", value: "\(page)"),
			URLQueryItem(name: "size", value: "\(size)")
		]
		
		if let sortBy = sortBy {
			queryItems.append(URLQueryItem(name: "sortBy", value: sortBy))
		}
		
		comps?.queryItems = queryItems
		return comps?.url
	}
}
