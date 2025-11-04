//
//  UserCollectionItemView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Алина on 25.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//
import SwiftUI

struct UserCollectionView: View {

	@State private var model: UserCollectionViewModel
	@Environment(StatisticCoordinator.self) private var coordinator

	private let columns = Array(repeating: GridItem(.flexible(), spacing: 9), count: 3)

	init(viewModel: UserCollectionViewModel) {
		_model = State(initialValue: viewModel)
	}

	var body: some View {
		ZStack {
			ScrollView {
				LazyVGrid(columns: columns, spacing: 2) {
					ForEach(model.items) { nft in
						let model = makeCardModel(for: nft)
						NFTCardView(
							model: model,
							onCartTap: { cartTap(for: nft.id) },
							onFavoriteTap: { favoriteTap(for: nft.id)}
						)
						.frame(minWidth: 108, maxWidth: .infinity)
						.frame(maxHeight: 192)
					}
				}
				.padding(.horizontal, 16)
				.padding(.top, 12)
				.padding(.bottom, 24)
			}
			.scrollIndicators(.hidden)
			.loading(model.isLoading)
		}
		.navigationBarBackButtonHidden()
		.toolbar {
			BackToolbar {
				coordinator.goBack()
			}
		}
		.navigationTitle("Коллекция NFT")
		.navigationBarTitleDisplayMode(.inline)
		.background(Color.ypWhite)
		.task {
			await model.makeLoadLikes()
			await model.makeLoadCart()
			await model.makeLoad()
		}
	}

	private func cartTap(for id: String) {
		guard !model.addingInProgress.contains(id) else { return }
		Task { await model.makeToggleCart(nftId: id) }
	}

	private func favoriteTap(for id: String) {
		guard !model.likingInProgress.contains(id) else { return }
		Task { await model.makeToggleLike(nftId: id) }
	}

	private func makeCardModel(for nft: NFTItem) -> NFTCardModel {
		NFTCardModel(
			name: nft.name,
			imageURL: nft.images.first,
			rating: nft.rating,
			price: nft.price,
			currency: .eth,
			favorite: model.isFavorite(nft.id),
			addedToCart: model.isInCart(nft.id)
		)
	}
}

#Preview {
	let root = RootCoordinatorImpl()
	let stat = StatisticCoordinator(rootCoordinator: root)

	let userCollectionVM = UserCollectionViewModel(
		nftIDs: MockNFTIDs.sample,
		service: MockNFTItemCollectionService(),
		profileService: UserCollectionViewModel.Default.makeProfileService()
	)

	return NavigationStack(path: stat.navigationPathBinding) {
		UserCollectionView(viewModel: userCollectionVM)
			.environment(stat)
			.navigationDestination(for: Screen.self) { screen in
				ViewFactory(rootCoordinator: root).makeScreenView(for: screen)
			}
	}
}
