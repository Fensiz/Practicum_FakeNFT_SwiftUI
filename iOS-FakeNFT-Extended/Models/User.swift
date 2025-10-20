//
//  User.swift
//  iOS-FakeNFT-Extended
//
//  Created by Алина on 11.10.2025.
//

import SwiftUI

struct User: Codable, Identifiable, Sendable {
    let name: String
    let avatar: URL?
    let description: String?
    let website: URL?
    let nfts: [String]
    let rating: String?
    let id: String
    let likes: [String]?  // ОПЦИОНАЛЬНЫЙ  для GET

    var ratingValue: Int {
        nfts.count
    }

    var likesArray: [String] {
        likes ?? []
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.name == rhs.name &&
        lhs.description == rhs.description &&
        lhs.website == rhs.website &&
        lhs.avatar == rhs.avatar
    }

    init(
        id: String,
        name: String,
        avatar: URL?,
        nfts: [String],
        rating: String? = nil,
        description: String? = nil,
        website: URL? = nil,
        likes: [String]? = nil
    ) {
        self.id = id
        self.name = name
        self.avatar = avatar
        self.nfts = nfts
        self.rating = rating
        self.description = description
        self.website = website
        self.likes = likes
    }
}
