//
//  ProfileUpdateDTO.swift
//  iOS-FakeNFT-Extended
//
//  Created by Hajime4life on 14.10.2025.
//

import Foundation

struct ProfileUpdateDTO: Encodable {
    let name: String
    let avatar: String?
    let description: String?
    let website: String?
    
    func toFormURLEncoded() -> Data? {
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "name", value: name),
            avatar.map { URLQueryItem(name: "avatar", value: $0) },
            description.map { URLQueryItem(name: "description", value: $0) },
            website.map { URLQueryItem(name: "website", value: $0) }
        ].compactMap { $0 }
        return components.query?.data(using: .utf8)
    }
}
