//
//  MyNFTList.swift
//  iOS-FakeNFT-Extended
//
//  Created by Hajime4life on 18.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import SwiftUI

struct MyNFTList: View {
	@Environment(\.dismiss) private var dismiss
	@State var viewModel: ProfileViewModel
	var body: some View {
		VStack {
			if viewModel.isLoadingMyNFTs {
				ProgressView()
					.frame(maxWidth: .infinity, maxHeight: .infinity)
			} else if let myNfts = viewModel.myNfts, !myNfts.isEmpty {
				ScrollView {
					VStack(spacing: 0) {
						ForEach(myNfts) { nft in
							MyNFTCell(
								nft: nft,
								author: viewModel.user?.name,
								isLiked: viewModel.isLiked(nftId: nft.id),
								onLikeTap: {
									Task { await viewModel.toggleLike(nftId: nft.id) }
								}
							)
							.padding([.vertical, .leading])
							.padding(.trailing, 39)
						}
					}
					.padding(.top, 20)
				}
			} else if viewModel.myNfts?.isEmpty == true {
				Text("У Вас ещё нет NFT")
					.foregroundColor(.ypBlack)
					.frame(maxWidth: .infinity, maxHeight: .infinity)
					.background(Color.ypWhite)
			}
		}
		.navigationTitle("Мои NFT")
		.navigationBarBackButtonHidden(true)
		.toolbar {
			ToolbarItem(placement: .topBarTrailing) {
				Button(action: viewModel.showSortContextMenu) {
					Image(.sort)
				}
				.foregroundColor(.ypBlack)
				.actionSheet(isPresented: $viewModel.wantToSortMyNft) {
					sortActionSheet
				}
			}
			ToolbarItem(placement: .topBarLeading) {
				Button(action: { dismiss() }) {
					Image(.chevronLeft)
				}
				.foregroundColor(.ypBlack)
			}
		}
		.background(Color.ypWhite)
		.task {
			await viewModel.loadMyNFTs()
		}
		.alert("Ошибка", isPresented: .constant(viewModel.errorMessage != nil)) {
			Button("Отмена", role: .cancel) { viewModel.clearError() }
			Button("Повторить") {
				Task { await viewModel.loadMyNFTs() }
			}
		} message: {
			Text(viewModel.errorMessage ?? "Не удалось получить данные")
		}
	}
	// MARK: - Сортировка
	private var sortActionSheet: ActionSheet {
		ActionSheet(
			title: Text("Сортировка"),
			buttons: [
				.default(Text("По цене")) { viewModel.sortMyNFTs(by: .price) },
				.default(Text("По рейтингу")) { viewModel.sortMyNFTs(by: .rating) },
				.default(Text("По названию")) { viewModel.sortMyNFTs(by: .name) },
				.cancel(Text("Закрыть"))
			]
		)
	}
}
