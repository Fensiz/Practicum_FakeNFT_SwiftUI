//
//  NFTCollectionsListView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vladimir on 15.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import SwiftUI

struct NFTCollectionsListView: View {

	@State private var viewModel: NFTCollectionsListViewModel
	@State private var isSelectingSortingType = false
	@State private var isShowingErrorAlert = false

	private let coordinator: any CatalogCoordinatorProtocol

	var body: some View {
		scrollView
			.confirmationDialog(
				"Sorting",
				isPresented: $isSelectingSortingType
			) {
				ForEach(CollectionsSortingType.allCases) { sorting in
					Button(sortingDescription(for: sorting)) {
						viewModel.sort(by: sorting)
					}
				}
			} message: {
				Text("Sorting")
			}
			.toolbarPreference(imageName: .sort) {
				isSelectingSortingType = true
			}
			.onAppear {
				viewModel.fetchCollections(isInitialFetch: true)
			}
			.alert(
				"Failed to retrieve data",
				isPresented: $isShowingErrorAlert
			) {
				Button { } label: {
					Text("Cancel")
						.font(DesignSystem.Font.bodyRegular)
				}
				Button {
					viewModel.fetchCollections(isInitialFetch: false)
				} label: {
					Text("Repeat")
						.font(DesignSystem.Font.bodyBold)
				}
			}
			.onChange(of: viewModel.state) { oldValue, newValue in
				if oldValue != .loaded && newValue == .loading {
					UIBlockingProgressHUD.show()
				}
				if oldValue == .loading && newValue == .loaded {
					UIBlockingProgressHUD.dismiss()
				}
				if newValue == .error {
					UIBlockingProgressHUD.dismiss()
					isShowingErrorAlert = true
				}
			}
	}

	private var scrollView: some View {
		ScrollView {
			VStack(spacing: DesignSystem.Spacing.small) {
				ForEach(viewModel.collections) { collection in
					button(for: collection)
						.onAppear {
							if collection == viewModel.collections.last {
								viewModel.fetchCollections(isInitialFetch: false)
							}
						}
				}
			}
			.padding(.horizontal, DesignSystem.Padding.medium)
			.padding(.vertical, DesignSystem.Padding.large)
		}
		.frame(maxWidth: .infinity)
		.background(.ypWhite)
	}

	private func button(for collectionCard: NFTCollectionCardModel) -> some View {
		Button {
			coordinator.showDetails(collectionID: collectionCard.id)
		} label: {
			NFTCollectionCellView(collection: collectionCard)
		}
		.buttonStyle(.plain)
	}

	private func sortingDescription(for sortingType: CollectionsSortingType) -> String {
		switch sortingType {
			case .byTitle:
				NSLocalizedString("By Title", comment: "")
			case .bySize:
				NSLocalizedString("By number of NFTs", comment: "")
		}
	}

	init(
		viewModel: NFTCollectionsListViewModel,
		coordinator: any CatalogCoordinatorProtocol
	) {
		self.viewModel = viewModel
		self.coordinator = coordinator
	}

}

#Preview {
	let rootCoordinator = RootCoordinatorImpl()
	let catalogCoordinator = CatalogCoordinator(rootCoordinator: rootCoordinator)
	let collectionsProvider = NFTCollectionsMockProvider(throwsError: false)
	let viewModel = NFTCollectionsListViewModel(collectionsProvider: collectionsProvider)
	NavigationStack {
		NFTCollectionsListView(
			viewModel: viewModel,
			coordinator: catalogCoordinator
		)
	}

}
