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

	private let coordinator: any CatalogCoordinatorProtocol

    var body: some View {
        scrollView
            .confirmationDialog(
                "sorting",
                isPresented: $isSelectingSortingType
            ) {
                ForEach(CatalogSorting.allCases) { sorting in
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
			.onChange(of: viewModel.state) { oldValue, newValue in
				if newValue == .loading && oldValue == .empty {
					UIBlockingProgressHUD.show()
				} else {
					UIBlockingProgressHUD.dismiss()
				}
			}
    }

    var scrollView: some View {
        ScrollView {
            LazyVStack(spacing: 8) {
				ForEach(viewModel.collections) { collection in
					button(for: collection)
						.onAppear {
							if collection == viewModel.collections.last {
								viewModel.fetchCollections()
							}
						}
				}
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 20)
        }
        .background(.ypWhite)
    }

    private func button(for collection: NFTCollectionModel) -> some View {
        Button {
			coordinator.showDetails(for: collection)
        } label: {
            NFTCollectionCellView(collection: collection)
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
