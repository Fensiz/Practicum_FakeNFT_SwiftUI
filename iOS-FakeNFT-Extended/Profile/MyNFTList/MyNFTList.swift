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
	@Bindable var viewModel: ProfileViewModel
	@State private var togglingLikeId: String?
	var body: some View {
		ZStack {
			contentView
				.disabled(viewModel.isTogglingLike)
			if viewModel.isTogglingLike {
				Color.black.opacity(0.2)
					.ignoresSafeArea()
				ProgressView()
					.scaleEffect(1.5)
					.padding()
					.background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
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
				.disabled(viewModel.isTogglingLike)
				.actionSheet(isPresented: $viewModel.wantToSortMyNft) {
					sortActionSheet
				}
			}
			ToolbarItem(placement: .topBarLeading) {
				Button { dismiss() } label: {
					Image(.chevronLeft)
						.foregroundColor(.ypBlack)
				}
				.disabled(viewModel.isTogglingLike)
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
	@ViewBuilder
	private var contentView: some View {
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
								isLiked: viewModel.isLiked(nftId: nft.id),
								onLikeTap: {
									let id = nft.id
									guard togglingLikeId != id else { return }
									guard !viewModel.isTogglingLike else { return }
									togglingLikeId = id
									Task {
										await viewModel.toggleLike(id)
										await MainActor.run {
											togglingLikeId = nil
										}
									}
								}
							)
							.opacity(togglingLikeId == nft.id ? 0.6 : 1.0)
							.animation(.easeInOut(duration: 0.2), value: togglingLikeId)
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
