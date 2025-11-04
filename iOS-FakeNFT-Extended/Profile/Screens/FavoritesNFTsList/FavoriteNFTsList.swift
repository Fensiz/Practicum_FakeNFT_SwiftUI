//
//  FavoriteNFTsList.swift
//  iOS-FakeNFT-Extended
//
//  Created by Hajime4life on 18.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import SwiftUI

struct FavoriteNFTsList: View {
	@Environment(\.dismiss) private var dismiss
	@Bindable var viewModel: ProfileViewModel
	@State private var togglingLikeId: String?

	var body: some View {
		ZStack {
			if let likedNfts = viewModel.likedNfts, !likedNfts.isEmpty {
				contentView
					.disabled(viewModel.isTogglingLike)
			} else {
				Text("У Вас ещё нет избранных NFT")
					.foregroundColor(.ypBlack)
					.font(DesignSystem.Font.bodyBold)
					.frame(maxWidth: .infinity, maxHeight: .infinity)
					.multilineTextAlignment(.center)
			}

			if viewModel.isTogglingLike {
				Color.black.opacity(0.2)
					.ignoresSafeArea()
				ProgressView()
					.scaleEffect(1.5)
					.padding()
					.background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
			}
		}
		.navigationTitle("Избранное")
		.navigationBarBackButtonHidden(true)
		.toolbar {
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
			await viewModel.loadLikedNFTs()
		}
		.alert("Ошибка", isPresented: .constant(viewModel.errorMessage != nil)) {
			Button("Отмена", role: .cancel) { viewModel.clearError() }
			Button("Повторить") {
				Task { await viewModel.loadLikedNFTs() }
			}
		} message: {
			Text(viewModel.errorMessage ?? "Не удалось получить данные")
		}
	}

	@ViewBuilder
	private var contentView: some View {
		ScrollView {
			if viewModel.isLoadingLikedNFTs {
				ProgressView()
					.frame(maxWidth: .infinity, maxHeight: .infinity)
			} else if let likedNfts = viewModel.likedNfts, !likedNfts.isEmpty {
				LazyVGrid(columns: [
					GridItem(.flexible(), spacing: 7),
					GridItem(.flexible(), spacing: 7)
				], spacing: 20) {
					ForEach(likedNfts) { nft in
						FavoriteNFTCell(
							nft: nft,
							isToggling: togglingLikeId == nft.id,
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
					}
				}
				.padding(20)
			} else {
				Text("У Вас ещё нет избранных NFT")
					.foregroundColor(.ypBlack)
					.frame(maxWidth: .infinity, maxHeight: .infinity)
			}
		}
	}
}
