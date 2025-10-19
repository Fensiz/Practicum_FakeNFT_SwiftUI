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
                Task {
                    await viewModel.fetchNewCollections(number: 10)
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
                                Task {
                                    await viewModel.fetchNewCollections(number: 10)
                                }
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
            print("\(collection) tapped")
        } label: {
            NFTCollectionCellView(collection: collection)
        }
        .buttonStyle(.plain)
    }

    init(viewModel: NFTCollectionsListViewModel) {
        self.viewModel = viewModel
    }

}

#Preview {
    NavigationStack {
        NFTCollectionsListView(
            viewModel: NFTCollectionsListViewModel(
                collectionsProvider: NFTCollectionsMockProvider()
            )
        )
    }

}
