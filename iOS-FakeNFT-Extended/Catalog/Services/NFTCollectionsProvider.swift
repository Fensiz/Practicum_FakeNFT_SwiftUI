//
//  NFTCollectionsProvider.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vladimir on 15.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import Foundation

protocol NFTCollectionsProviderProtocol: Sendable {
    func fetch(number: Int) async throws -> [NFTCollectionModel]
}

actor NFTCollectionsProvider: NFTCollectionsProviderProtocol {

    nonisolated private func getNFT(id: NFTCollectionModel.ID) -> NFTCollectionModel {
        .init(
            imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Обложки_коллекций/Beige.png"),
            title: "Beige",
            nftIDs: [1, 2, 3, 4],
            description: "A series of ...",
            authorID: 49,
            id: id
        )
    }

    nonisolated func fetch(number: Int) async throws -> [NFTCollectionModel] {
        try? await Task.sleep(for: .seconds(3))
        return (0..<number).map { _ in Int.random(in: 0..<10_000_000) }.map { getNFT(id: $0)}
    }

}
