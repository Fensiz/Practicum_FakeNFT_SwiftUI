//
//  User.swift
//  iOS-FakeNFT-Extended
//
//  Created by Алина on 11.10.2025.
//

import SwiftUI

struct User: Codable, Identifiable, Sendable, Equatable {
    var name: String
    var avatar: URL?
    var description: String?
    var website: URL?
    let nfts: [String]
    let rating: String?
    let id: String
    var likes: [String]? // ОПЦИОНАЛЬНЫЙ для GET

    var ratingValue: Int {
        nfts.count
    }

    var likesArray: [String] { // TODO: Может убрать?
        likes ?? []
    }
//    static func == (lhs: User, rhs: User) -> Bool {
//        lhs.name == rhs.name &&
//        lhs.description == rhs.description &&
//        lhs.website == rhs.website &&
//        lhs.avatar == rhs.avatar
//    }

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
