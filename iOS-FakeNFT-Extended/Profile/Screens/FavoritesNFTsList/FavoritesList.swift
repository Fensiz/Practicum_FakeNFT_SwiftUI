//
//  FavoritesList.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 31.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import SwiftUI

struct FavoritesList: View {
	@State var viewModel: FavoritesListViewModel
	let backAction: () -> Void
	private let columns = Array(repeating: GridItem(.flexible(), spacing: 7), count: 2)

	var body: some View {
		ZStack {
			DesignSystem.Color.background
				.ignoresSafeArea()
			if viewModel.nftIDs.isEmpty {
				Text("У Вас ещё нет избранных NFT")
					.font(DesignSystem.Font.bodyBold)
					.foregroundColor(DesignSystem.Color.textPrimary)
			} else {
				LazyVGrid(columns: columns, spacing: 20) {
					ForEach(viewModel.nftIDs, id: \.self) { id in
						FavoritesCell(item: viewModel.nftCache[id]?.favoriteModel) {
							await viewModel.unlike(nftID: id)
						}
						.task {
							await viewModel.loadNFTIfNeeded(for: id)
						}
					}
				}
				.frame(maxHeight: .infinity, alignment: .top)
				.padding(.horizontal, 16)
				.padding(.vertical, 20)
			}
		}
		.navigationTitle("Избранные NFT")
		.navigationBarBackButtonHidden()
		.toolbar {
			BackToolbar(action: backAction)
		}
	}
}

#Preview {
	let viewModel = FavoritesListViewModel(
		nftService: NftServiceImpl(networkClient: DefaultNetworkClient(), storage: NftStorageImpl()),
		nftIDs: ["ba441c43-cf07-4f94-9ea8-082b3436c729", "1464520d-1659-4055-8a79-4593b9569e48"],
		unlikeAction: {_ in}
	)
	FavoritesList(viewModel: viewModel, backAction: {})
}
