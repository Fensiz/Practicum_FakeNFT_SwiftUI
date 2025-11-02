//
//  NFTCollectionDetailsView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vladimir on 19.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import SwiftUI
import Kingfisher

struct NFTCollectionDetailsView: View {

	private let coordinator: any CatalogCoordinatorProtocol

	@State private var viewModel: NFTCollectionDetailsViewModel
	@State private var isShowingErrorAlert = false

	@Environment(\.dismiss) private var dismiss
	private let columns: [GridItem] = [
		GridItem(.adaptive(minimum: 108))
	]

	private var details: NFTCollectionDetailsModel? {
		viewModel.details
	}

	private var nfts: [NFTModel] {
		viewModel.nfts
	}

	init(
		viewModel: NFTCollectionDetailsViewModel,
		coordinator: any CatalogCoordinatorProtocol
	) {
		self.viewModel = viewModel
		self.coordinator = coordinator
	}

	var body: some View {
		ScrollView {
			collectionImage
			collectionDetails
				.padding(.horizontal, 16)
				.padding(.top, 16)
			nftsGrid
				.padding(.horizontal, 16)
				.padding(.vertical, 24)
			Spacer()
		}
		.scrollIndicators(.hidden)
		.ignoresSafeArea(edges: .vertical)
		.background(.ypWhite)
		.navigationBarBackButtonHidden()
		.toolbar {
			backButton
		}
		.toolbarBackground(.hidden, for: .navigationBar)
		.alert(
			"Failed to retrieve data",
			isPresented: $isShowingErrorAlert
		) {
			Button { } label: {
				Text("Cancel")
					.font(.system(size: 17, weight: .regular))
			}
			Button {
				viewModel.onErrorCallback()
			} label: {
				Text("Repeat")
					.font(.system(size: 17, weight: .bold))
			}
		}
		.onChange(of: viewModel.state) { _, newValue in
			if newValue == .loading {
				UIBlockingProgressHUD.show()
			} else {
				UIBlockingProgressHUD.dismiss()
			}
			if newValue == .error {
				isShowingErrorAlert = true
			}
		}
	}

	private var collectionImage: some View {
		// somehow basic image here is not working properly
		// BasicImage(imageURL: details?.imageURL, contentMode: .fill)
		KFImage(details?.imageURL)
			.resizable()
			.placeholder {
				ProgressView()
					.tint(.ypBlack)
			}
			.scaledToFill()
			.frame(height: 310)
			.clipShape(
				UnevenRoundedRectangle(
					bottomLeadingRadius: 12,
					bottomTrailingRadius: 12
				)
			)
	}

	private var collectionDetails: some View {
		HStack {
			CollectionDetailsHeaderView(
				collectionTitle: details?.title ?? "",
				authorName: details?.authorName ?? "",
				collectionDescription: details?.description ?? "",
				onAuthorTap: {
					guard let url = details?.authorWebsite else { return }
					coordinator.showWebView(for: url)
				}
			)
			Spacer()
		}
	}

	private var nftsGrid: some View {
		LazyVGrid(
			columns: columns,
			alignment: .center,
			spacing: 28
		) {
			ForEach(viewModel.nfts) { nft in
				VStack(spacing: .zero) {
					NFTCardView(
						name: nft.title,
						imageURL: nft.primaryImageURL,
						rating: nft.rating,
						price: nft.price,
						currency: nft.currency,
						isFavorite: nft.isFavourite,
						isAddedToCart: nft.isAddedToCart,
						onCartTap: {
							viewModel.updateCartState(for: nft)
						},
						onFavoriteTap: {
							viewModel.updateFavoriteState(for: nft)
						}
					)
				}
				.frame(maxHeight: .infinity, alignment: .top)
			}
		}
	}

	private var backButton: some ToolbarContent {
		ToolbarItem(placement: .topBarLeading) {
			Button {
				dismiss()
			} label: {
				Image(.chevronLeft)
					.foregroundStyle(.ypBlack)
			}
		}
	}

}

// MARK: - Previews
#Preview("No error") {
	let collection = NFTCollectionCardModel(
		id: UUID(),
		title: "unum reque",
		imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Обложки_коллекций/White.png")!,
		nftsCount: 3
	)
	let rootCoordinator = RootCoordinatorImpl()
	let catalogCoordinator = CatalogCoordinator(rootCoordinator: rootCoordinator)
	let service = NFTCollectionDetailsMockService(throwsError: false)
	let viewModel = NFTCollectionDetailsViewModel(
		collectionID: collection.id,
		collectionDetailsService: service
	)
	NavigationStack {
		NFTCollectionDetailsView(
			viewModel: viewModel,
			coordinator: catalogCoordinator
		)
	}
}

#Preview("With Error") {
	let collection = NFTCollectionCardModel(
		id: UUID(),
		title: "unum reque",
		imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Обложки_коллекций/White.png")!,
		nftsCount: 3
	)
	let rootCoordinator = RootCoordinatorImpl()
	let catalogCoordinator = CatalogCoordinator(rootCoordinator: rootCoordinator)
	let service = NFTCollectionDetailsMockService(throwsError: true)
	let viewModel = NFTCollectionDetailsViewModel(
		collectionID: collection.id,
		collectionDetailsService: service
	)
	NavigationStack {
		NFTCollectionDetailsView(
			viewModel: viewModel,
			coordinator: catalogCoordinator
		)
	}
}
