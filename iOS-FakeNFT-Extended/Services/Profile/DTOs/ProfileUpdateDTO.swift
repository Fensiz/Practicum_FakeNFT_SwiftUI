//
//  ProfileUpdateDTO.swift
//  iOS-FakeNFT-Extended
//
//  Created by Hajime4life on 14.10.2025.
//

import Foundation

struct ProfileUpdateDTO: Encodable {
    let name: String?
    let avatar: String?
    let description: String?
    let website: String?
    let likes: [String]?

    func toFormURLEncoded() -> Data? {
        var components = URLComponents()
        var queryItems = [URLQueryItem]()

        if let name {
            queryItems.append(URLQueryItem(name: "name", value: name))
        }
        if let avatar {
            queryItems.append(URLQueryItem(name: "avatar", value: avatar))
        }
        if let description {
            queryItems.append(URLQueryItem(name: "description", value: description))
        }
        if let website {
            queryItems.append(URLQueryItem(name: "website", value: website))
        }
        if let likes {
            if likes.isEmpty {
                queryItems.append(URLQueryItem(name: "likes", value: "null"))  // ключевое
            } else {
                for id in likes {
                    queryItems.append(URLQueryItem(name: "likes[]", value: id))
                }
            }
        }

        components.queryItems = queryItems
        return components.query?.data(using: .utf8)
    }
}
