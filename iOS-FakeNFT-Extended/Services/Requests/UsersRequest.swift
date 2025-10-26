//
//  UsersRequest.swift
//  iOS-FakeNFT-Extended
//
//  Created by Алина on 26.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//
import Foundation

struct UsersRequest: NetworkRequest, Sendable {
    var endpoint: URL? {
        var comps = URLComponents(string: RequestConstants.baseURL)
        comps?.path = "/api/v1/users"
        return comps?.url
    }
}
