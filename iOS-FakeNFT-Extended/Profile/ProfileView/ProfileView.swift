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
		VStack(alignment: .leading, spacing: DesignSystem.Spacing.large2) {
			if let user = viewModel.user {
				Group {
					ProfileTopView(
						profile: viewModel.profile,
						urlAction: coordinator.openWebsite
					)

					VStack(spacing: .zero) {
						if !user.nfts.isEmpty {
							ProfileCellButtonView(title: "Мои NFT", count: user.nfts.count) {
								coordinator.openMyNFTs()
							}
						}
						if let likes = user.likes, !likes.isEmpty {
							ProfileCellButtonView(title: "Избранные NFT", count: likes.count) {
								coordinator.openLikedNFTs(ids: likes, unlikeAction: viewModel.toggleLike)
							}
						}
					}
				}
				.toolbarPreference(imageName: .squareAndPencil) {
					coordinator.openProfileEditScreen(
						for: viewModel.profile,
						saveAction: viewModel.updateProfile
					)
				}
			}
		}
		.loading(viewModel.isLoading)
		.padding(.horizontal)

		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
		.background(DesignSystem.Color.background)
		.task {
			await viewModel.loadProfile()
		}
	}
//	// MARK: - SubViews:
//	@ViewBuilder
//	private func navButton(title: String, count: Int) -> some View {
//		HStack {
//			Text("\(title) (\(count))")
//				.font(Font(UIFont.bodyBold))
//			Spacer()
//			Image(systemName: "chevron.forward")
//		}
//		.foregroundColor(.ypBlack)
//		.padding(.vertical)
//	}
}
#Preview {
	let net = DefaultNetworkClient()
	let store = NftStorageImpl()
	let profileService = ProfileServiceImpl(networkClient: net)
	let nftService = NftServiceImpl(networkClient: net, storage: store)
	let viewModel = ProfileViewModel(profileService: profileService, nftsService: nftService)
	let coord = ProfileCoordinatorImpl(rootCoordinator: RootCoordinatorImpl())
	ProfileView(viewModel: viewModel, coordinator: coord)
}

private struct ProfileCellButtonView: View {
	let title: String
	let count: Int
	let action: () -> Void

	var body: some View {
		Button(action: action) {
			HStack {
				Text("\(title) (\(count))")
					.font(DesignSystem.Font.bodyBold)
				Spacer()
				Image(systemName: "chevron.forward")
			}
			.foregroundColor(.ypBlack)
		}
		.frame(height: 54)
	}
}
struct ProfileModel {
	let avatar: URL?
	let name: String
	let description: String?
	let website: URL?
	let nfts: [String]
	let likes: [String]
}

struct ShortProfileModel: Equatable {
	var avatar: URL?
	var name: String
	var description: String?
	var website: URL?

	var avatarString: String {
		get { avatar?.absoluteString ?? "" }
		set { avatar = URL(string: newValue) }
	}

	var websiteString: String {
		get { website?.absoluteString ?? "" }
		set { website = URL(string: newValue) }
	}
}

private struct ProfileTopView: View {
	let profile: ShortProfileModel
	let urlAction: (URL) -> Void

	var body: some View {
		VStack(alignment: .leading, spacing: DesignSystem.Spacing.small) {
			VStack(alignment: .leading, spacing: DesignSystem.Spacing.large) {
				HStack(spacing: DesignSystem.Spacing.medium2) {
					AvatarView(imageURL: profile.avatar)
					Text(profile.name)
						.foregroundColor(DesignSystem.Color.textPrimary)
						.font(DesignSystem.Font.headline3)
				}
				if let description = profile.description {
					Text(description)
						.font(DesignSystem.Font.caption2)
						.foregroundColor(DesignSystem.Color.textPrimary)
				}
			}
			if let website = profile.website {
				Button {
					urlAction(website)
				} label: {
					Text(website.absoluteString)
						.lineLimit(1)
						.foregroundColor(.ypUBlue)
						.frame(maxWidth: .infinity, alignment: .leading)
				}
				.frame(height: 28)
			}
		}
	}
}
