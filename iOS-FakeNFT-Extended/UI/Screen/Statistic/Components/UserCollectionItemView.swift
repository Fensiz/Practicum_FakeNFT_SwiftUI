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

	init(viewModel: UserCollectionViewModel) {
		_viewModel = State(initialValue: viewModel)
	}

	var body: some View {
		ZStack {
			ScrollView {
				LazyVGrid(columns: columns, spacing: 2) {
					ForEach(viewModel.items) { nft in
						let model = NFTCardViewModel(
							name: nft.name,
							imageURL: nft.images.first,
							rating: nft.rating,
							price: nft.price,
							currency: .eth,
							isFavorite: viewModel.isFavorite(nft.id),
							isAddedToCart: viewModel.isInCart(nft.id),
							onCartTap: { cartTap(for: nft.id) },
							onFavoriteTap: { favoriteTap(for: nft.id)}
						)

						NFTCardView(model: model)
							.frame(minWidth: 108, maxWidth: .infinity)
							.frame(maxHeight: 192)
					}
				}
				.padding(.horizontal, 16)
				.padding(.top, 12)
				.padding(.bottom, 24)
			}
			if viewModel.isLoading {
				ProgressView()
					.scaleEffect(1.5)
					.frame(maxWidth: .infinity, maxHeight: .infinity)
					.background(Color.ypWhite.opacity(0.8))
			}
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
			await viewModel.makeLoadLikes()
			await viewModel.makeLoadCart()
			await viewModel.makeLoad()
		}
	}

	private func cartTap(for id: String) {
		guard !viewModel.addingInProgress.contains(id) else { return }
		Task { await viewModel.makeToggleCart(nftId: id) }
	}

	private func favoriteTap(for id: String) {
		guard !viewModel.likingInProgress.contains(id) else { return }
		Task { await viewModel.makeToggleLike(nftId: id) }
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
