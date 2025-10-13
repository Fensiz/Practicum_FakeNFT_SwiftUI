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
    let rating: String
    let id: String

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
        website: URL? = nil
    ) {
        self.id = id
        self.name = name
        self.avatar = avatar
        self.nfts = nfts
        self.rating = rating
        self.description = description
        self.website = website
    }
}
