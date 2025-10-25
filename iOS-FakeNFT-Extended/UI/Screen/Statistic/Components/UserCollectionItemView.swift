//
//  UserCollectionItemView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Алина on 25.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//
import SwiftUI

struct UserCollectionView: View {

    let nftsData: NFTItem

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 3)

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, alignment: .leading, spacing: 0) {
                ForEach(Array(nftsData.nfts.enumerated()), id: \.offset) { index, _ in
                    nftCard(for: index)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 12)
            .padding(.bottom, 24)
        }
        .navigationTitle("Коллекция NFT")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func nftCard(for index: Int) -> some View {
        NFTCardView(
            name: nftsData.name,
            imageURL: nil, // будет позже подключено К IP
            rating: 2, //будет позже подключено К IP
            price: 0, // будет позже подключено К IP
            currency: .eth,
            isFavorite: false,// будет позже подключено К IP
            isAddedToCart: false,// будет позже подключено К IP
            onCartTap: {},// будет позже подключено
            onFavoriteTap: {} // будет позже подключено
        )
    }

    private func imageURL(for _: Int) -> URL? {
        nftsData.images?.first
    }
}

#Preview {
    NavigationStack {
        UserCollectionView(nftsData: NFTItem(
            name: "Demo",
            nfts: [
                "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Ellsa/1.png",
                "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Ellsa/2.png",
                "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Ellsa/3.png"
            ],
            id: "81268b05-db02-4bc9-b0b0-f7136de49706"))
    }
}
