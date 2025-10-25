//
//  NFTItemViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Алина on 25.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//
import Foundation

///  Данные будут подключены к /api/v1/collections/{collection_id} и /api/v1/collections
struct NFTItem: Identifiable, Hashable, Sendable {
    let createdAt: String?
    let name: String
    let cover: String?
    let nfts: [String]
    let description: String?
    let author: String?
    let id: String
    let images: [URL]?

    init(
        name: String,
        nfts: [String],
        id: String,
        createdAt: String? = nil,
        cover: String? = nil,
        description: String? = nil,
        author: String? = nil,
        images: [URL]? = nil
    ) {
        self.createdAt = createdAt
        self.name = name
        self.cover = cover
        self.nfts = nfts
        self.description = description
        self.author = author
        self.id = id
        self.images = images
    }
}
