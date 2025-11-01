//
//  UserCollectionItemView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Алина on 25.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//
import SwiftUI

struct UserCollectionView: View {

    @State private var viewModel: UserCollectionViewModel
    @Environment(StatisticCoordinator.self) private var coordinator

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 9), count: 3)

    init(
        nftIDs: [String],
        service: any NFTItemCollectionService = UserCollectionViewModel.Default.nftService
    ) {
        _viewModel = State(initialValue: UserCollectionViewModel(nftIDs: nftIDs, service: service))
    }

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 2) {
                ForEach(viewModel.items) { nft in
                    NFTCardView(
                        name: nft.name,
                        imageURL: nft.images.first,
                        rating: nft.rating,
                        price: nft.price,
                        currency: .eth,
                        isFavorite: false,
                        isAddedToCart:
                            viewModel.cartIds.contains(nft.id)||viewModel.addingInProgress.contains(nft.id),
                        onCartTap: {
                            guard !viewModel.addingInProgress.contains(nft.id) else { return }
                            Task { await viewModel.makeToggleCart(nftId: nft.id) }
                        },
                        onFavoriteTap: {}
                    )
                    .frame(minWidth: 108, maxWidth: .infinity)
                    .frame(maxHeight: 192)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 12)
            .padding(.bottom, 24)
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            BackToolbar {
                coordinator.goBack()
            }
        }
        .navigationTitle("Коллекция NFT")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color(.systemBackground), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .task {
            await viewModel.makeLoad()
        }
    }
}

#Preview {
    NavigationStack {
        UserCollectionView(nftIDs: MockNFTIDs.sample, service: MockNFTItemCollectionService())
    }
    .environment(StatisticCoordinator.shared)
}
