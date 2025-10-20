//
//  NFTCollectionDetailsView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vladimir on 19.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import SwiftUI

struct NFTCollectionDetailsView: View {

	@State private var viewModel: NFTCollectionDetailsViewModel

	@Environment(\.dismiss) private var dismiss
	let columns: [GridItem] = [
		GridItem(.adaptive(minimum: 108))
	]

	var collection: NFTCollectionModel {
		viewModel.collection
	}

	var nfts: [NFTModel] {
		viewModel.nfts
	}

	var author: NFTUserModel? {
		viewModel.author
	}

	init(viewModel: NFTCollectionDetailsViewModel) {
		self.viewModel = viewModel
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
		.alert(NSLocalizedString("CatalogDetails.Error", comment: ""), isPresented: $viewModel.hasError) {
			Button { } label: {
				Text(NSLocalizedString("Error.Cancel", comment: ""))
					.font(.system(size: 17, weight: .regular))
			}
			Button {
				viewModel.updateDetails()
			} label: {
				Text(NSLocalizedString("Error.Repeat", comment: ""))
					.font(.system(size: 17, weight: .bold))
			}
		}
	}

	var collectionImage: some View {
		AsyncImage(url: collection.imageURL) { phase in
			let errorImage = Image(systemName: "exclamationmark.triangle.fill")
				.resizable()
				.scaledToFit()
				.foregroundStyle(.ypBlack)
			switch phase {
			case .empty:
				VStack(spacing: .zero) {
					Spacer()
					ProgressView()
						.tint(.ypBlack)
					Spacer()
				}
			case .success(let image):
				image
					.resizable()
					.scaledToFill()
			case .failure:
				errorImage
			@unknown default:
				errorImage
			}
		}
		.frame(height: 310)
		.clipShape(
			UnevenRoundedRectangle(
				bottomLeadingRadius: 12,
				bottomTrailingRadius: 12
			)
		)
	}

	var collectionDetails: some View {
		HStack {
			CollectionDetailsHeaderView(
				collectionTitle: collection.title,
				authorName: author?.name ?? "",
				collectionDescription: collection.description,
				onAuthorTap: {
					viewModel.authorTapped()
				}
			)
			Spacer()
		}
	}

	var nftsGrid: some View {
		LazyVGrid(
			columns: columns,
			alignment: .center,
			spacing: 28
		) {
			ForEach(viewModel.nfts) { nft in
				VStack(spacing: .zero) {
					NFTCardView(
						name: nft.name,
						imageURL: nft.imageURL,
						rating: nft.rating,
						price: nft.price,
						currency: nft.currency,
						isFavorite: nft.isFavourite,
						isAddedToCart: nft.isAddedToCart,
						onCartTap: {
							viewModel.cartTapped(for: nft)
						},
						onFavoriteTap: {
							viewModel.favoriteTapped(for: nft)
						}
					)
				}
				.frame(maxHeight: .infinity, alignment: .top)
			}
		}
	}

	var backButton: some ToolbarContent {
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
	let collection = NFTCollectionModel(
		id: UUID(),
		title: "unum reque",
		imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Обложки_коллекций/White.png")!,
		nftIDs: Array(repeating: UUID(), count: 2),
		description: "dictas ...",
		authorID: UUID()
	)
	let rootCoordinator = RootCoordinatorImpl()
	let catalogCoordinator = CatalogCoordinator(rootCoordinator: rootCoordinator)
	let service = NFTCollectionDetailsMockService(throwsError: false)
	let viewModel = NFTCollectionDetailsViewModel(
		collection: collection,
		collectionDetailsService: service,
		coordinator: catalogCoordinator
	)
	NavigationStack {
		NFTCollectionDetailsView(
			viewModel: viewModel
		)
	}
}

#Preview("With Error") {
	let collection = NFTCollectionModel(
		id: UUID(),
		title: "unum reque",
		imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Обложки_коллекций/White.png")!,
		nftIDs: Array(repeating: UUID(), count: 2),
		description: "dictas ...",
		authorID: UUID()
	)
	let rootCoordinator = RootCoordinatorImpl()
	let catalogCoordinator = CatalogCoordinator(rootCoordinator: rootCoordinator)
	let service = NFTCollectionDetailsMockService(throwsError: true)
	let viewModel = NFTCollectionDetailsViewModel(
		collection: collection,
		collectionDetailsService: service,
		coordinator: catalogCoordinator
	)
	NavigationStack {
		NFTCollectionDetailsView(
			viewModel: viewModel
		)
	}
}
