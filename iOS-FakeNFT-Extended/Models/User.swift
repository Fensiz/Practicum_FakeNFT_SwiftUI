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
    static var mock: User {
        .init(
            id: "ADFasda2sadasd",
            name: "Joaquin Phoenix",
            avatar: URL(string: "https://i.ibb.co/fVLFtWrM/c1f8f42c5f5bd684e27d93131dc6ffd4696cdfd3.jpg")!,
            nfts: ["1", "2", "3"],
            rating: "4.5"
        )
    }
    static var mock2: User {
        .init(
            id: "ADFasda2sadasd",
            name: "Joaquin Phoenix",
            avatar: URL(string: "https://i.ibb.co/fVLFtWrM/c1f8f42c5f5bd684e27d93131dc6ffd4696cdfd3.jpg")!,
            nfts: ["1", "2", "3"],
            rating: "4.5",
            description: "Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям."
        )
    }
}
