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
    var addingInProgress: Set<String> = []
    var cartIds: Set<String> = []

    var likedIds: Set<String> = []
    var likingInProgress: Set<String> = []
    private let profileId: String = "1"

    init(
        nftIDs: [String],
        service: any NFTItemCollectionService
    ) {
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

    @MainActor
    func makeToggleCart(nftId: String) async {
        guard !addingInProgress.contains(nftId) else { return }
        addingInProgress.insert(nftId)
        defer { addingInProgress.remove(nftId) }

        let willAdd = !cartIds.contains(nftId)
        if willAdd {
            cartIds.insert(nftId)
        } else {
            cartIds.remove(nftId)
        }

        do {
            let client = DefaultNetworkClient()
            let payload = cartIds.isEmpty ? [""] : Array(cartIds)
            let request = OrdersRequest(httpMethod: .put, nfts: payload)
            _ = try await client.send(request: request)
        } catch {
            if willAdd {
                cartIds.remove(nftId)
            } else {
                cartIds.insert(nftId)
            }
            errorMessage = willAdd ? "Не удалось добавить в корзину" : "Не удалось удалить из корзины"
        }
    }

    @MainActor
    func makeToggleLike(nftId: String) async {
        guard !likingInProgress.contains(nftId) else { return }
        likingInProgress.insert(nftId); defer { likingInProgress.remove(nftId) }

        let willLike = !likedIds.contains(nftId)
        if willLike { likedIds.insert(nftId) } else { likedIds.remove(nftId) }

        do {
            let req = MockProfileAPI.ProfileFormRequest.putLikes(
                profileId: profileId,
                likes: Array(likedIds)
            )
            _ = try await DefaultNetworkClient().send(request: req) as Data
        } catch {
            if willLike { likedIds.remove(nftId) } else { likedIds.insert(nftId) }
            errorMessage = willLike ? "Не удалось поставить лайк" : "Не удалось убрать лайк"
        }
    }
}

extension UserCollectionViewModel {
    enum Default {
        static let nftService: any NFTItemCollectionService =
        NFTCollectionsServiceImpl(networkClient: DefaultNetworkClient())
    }
}
