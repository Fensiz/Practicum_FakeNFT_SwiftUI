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
				"sorting",
				isPresented: $isSelectingSortingType
			) {
				ForEach(CollectionsSortingType.allCases) { sorting in
					Button(sorting.description) {
						viewModel.sort(by: sorting)
					}
				}
			} message: {
				Text(NSLocalizedString("Catalog.Sorting", comment: ""))
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
						.font(.system(size: 17, weight: .regular))
				}
				Button {
					viewModel.fetchCollections(isInitialFetch: false)
				} label: {
					Text("Repeat")
						.font(.system(size: 17, weight: .bold))
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
			VStack(spacing: 8) {
				ForEach(viewModel.collections) { collection in
					button(for: collection)
						.onAppear {
							if collection == viewModel.collections.last {
								viewModel.fetchCollections(isInitialFetch: false)
							}
						}
				}
			}
			.padding(.horizontal, 16)
			.padding(.vertical, 20)
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
