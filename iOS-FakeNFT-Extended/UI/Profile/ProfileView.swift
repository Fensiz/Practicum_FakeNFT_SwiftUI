//
//  ProfileView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Герман on 10.10.2025.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: ProfileViewModel
    let coordinator: any ProfileCoordinator
    var body: some View {
        VStack(alignment: .leading) {
            if let user = viewModel.user { // TODO: заменить на стейты
                ProfileInfo(user: user)
				if let website = user.website {
					Button(action: {
						coordinator.openWebsite(url: website)
					}) {
						Text(website.absoluteString)
							.lineLimit(1)
							.foregroundColor(.ypUBlue)
							.padding(.top, 8)
							.frame(maxWidth: .infinity, alignment: .leading)
					}
				}
				Button(action: {
					coordinator.openMyNFTs()
				}) {
					navButton(title: "Мои NFT", count: user.nfts.count)
				}
				.padding(.top, 40)
                
                Button(action: {/* TODO: nav - FavoriteNFTsList().env*/}) {
                    navButton(title: "Избранные NFT", count: user.likes?.count ?? 0)
                }
                Spacer()
            } else {
                // TODO: Заменить на LoadingView()
                ProgressView()
            }
        }
        .padding(.horizontal)
        .toolbarPreference(
            imageName: .squareAndPencil,
            action: {
                guard let _ = viewModel.user else { return }
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
        Button(action: {}) {
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
}
