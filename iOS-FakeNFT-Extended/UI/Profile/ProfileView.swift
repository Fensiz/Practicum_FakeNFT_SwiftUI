//
//  ProfileView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Герман on 10.10.2025.
//

import SwiftUI

struct ProfileView: View {
	@State var viewModel: ProfileViewModel
	let coordinator: any ProfileCoordinator
	var body: some View {
		VStack(alignment: .leading) {
			if let user = viewModel.user { // TODO: заменить на стейты
				ProfileInfo(user: user)
				if let website = user.website {
					Button {
						coordinator.openWebsite(url: website)
					} label: {
						Text(website.absoluteString)
							.lineLimit(1)
							.foregroundColor(.ypUBlue)
							.padding(.top, 8)
							.frame(maxWidth: .infinity, alignment: .leading)
					}
				}
				Button {
					coordinator.openMyNFTs()
				} label: {
					navButton(title: "Мои NFT", count: user.nfts.count)
				}
				.padding(.top, 40)
				Button {
					coordinator.openLikedNFTs()
				} label: {
					navButton(title: "Избранные NFT", count: user.likes?.count ?? 0)
				}
				Spacer()
			} else {
				ProgressView() // TODO: Заменить на LoadingView()
			}
		}
		.padding(.horizontal)
		.toolbarPreference(
			imageName: .squareAndPencil,
			action: {
				guard viewModel.user != nil else { return }
				coordinator.openProfileEdit()
			}
		)
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(Color.ypWhite)
		.task {
			await viewModel.loadProfile()
		}
	}
	// MARK: - SubViews:
	@ViewBuilder
	private func navButton(title: String, count: Int) -> some View {
		HStack {
			Text("\(title) (\(count))")
				.font(Font(UIFont.bodyBold))
			Spacer()
			Image(systemName: "chevron.forward")
		}
		.foregroundColor(.ypBlack)
		.padding(.vertical)
	}
}
