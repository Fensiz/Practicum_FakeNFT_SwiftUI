//
//  UserCollectionViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Алина on 28.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//
import Foundation
import Observation

@Observable
final class UserCollectionViewModel {

    private let nftIDs: [String]
    private let service: any NFTItemCollectionService

    var items: [NFTItem] = []
    var isLoading = false
    var errorMessage: String?
    var failedIDs: [String] = []

    init(nftIDs: [String], service: any NFTItemCollectionService) {
        var seen = Set<String>()
        self.nftIDs = nftIDs.filter { seen.insert($0).inserted }
        self.service = service
    }

    @MainActor
    func makeLoad() async {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil
        failedIDs = []
        items = []

        let ids = self.nftIDs
        let svc = self.service

        let (orderedItems, failed) = await Self.fetchItems(ids: ids, service: svc)

        self.items = orderedItems
        self.failedIDs = failed

        if items.isEmpty && !failed.isEmpty {
            self.errorMessage = "Не удалось загрузить NFT. Повторите попытку позже."
        }
        self.isLoading = false
    }

    private static func fetchItems (ids: [String],
                                    service: any NFTItemCollectionService
    ) async -> ([NFTItem], [String]) {

        var results: [Int: NFTItem] = [:]
        var failed: [String] = []

        await withTaskGroup(of: (Int, String, NFTItem?).self) { group in
            for (index, id) in ids.enumerated() {
                group.addTask {
                    do {
                        let item = try await service.loadNft(id: id)
                        return (index, id, item)
                    } catch {
                        return (index, id, nil)
                    }
                }
            }

            for await (index, id, item) in group {
                if let item {
                    results[index] = item
                } else {
                    failed.append(id)
                }
            }
        }

        let ordered = (0..<ids.count).compactMap { results[$0] }
        return (ordered, failed)
    }
}

extension UserCollectionViewModel {
    enum Default {
        static let nftService: any NFTItemCollectionService =
        NFTCollectionsServiceImpl(networkClient: DefaultNetworkClient())
    }
}
