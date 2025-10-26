//
//  User.swift
//  iOS-FakeNFT-Extended
//
//  Created by Алина on 11.10.2025.
//
import SwiftUI

struct User: Codable, Identifiable, Sendable, Equatable, Hashable {
    var name: String
    var avatar: URL?
    var description: String?
    var website: URL?
    var nfts: [String]
    var rating: String?
    let id: String
    var likes: [String]?

    var ratingValue: Int {
        nfts.count
    }

    init(
        id: String,
        name: String,
        avatar: URL?,
        nfts: [String],
        rating: String,
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
