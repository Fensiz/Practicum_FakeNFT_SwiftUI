//
//  UserCard.swift
//  iOS-FakeNFT-Extended
//
//  Created by Алина on 18.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//
import SwiftUI

struct UserCard: View {
    enum Constants {
        static let titleButton = "Перейти на сайт пользователя"
        static let safeTop: CGFloat = 20
        static let safeLeading: CGFloat = 16
        static let containerSpacing: CGFloat = 41
        static let bioSpacing: CGFloat = 28
        static let profileLineLimit: Int = 4
        static let profileLineSpacing: CGFloat = 5
        static let profileTrailingFix: CGFloat = 2
        static let bioTrailing: CGFloat = 16
        static let buttonMinHeight: CGFloat = 44
    }

    let user: User
    @Environment(StatisticCoordinator.self) private var coordinator

    private var websiteURL: URL {
        user.website ?? MockWebsiteURL.url
    }

    var body: some View {
        ScrollView {
            VStack(spacing: Constants.containerSpacing) {
                bioContent
                contentButton
            }
            .navigationBarBackButtonHidden()
            .toolbar {
                BackToolbar {
                    coordinator.goBack()
                }
            }
            .safeAreaPadding(.top, Constants.safeTop)
            .safeAreaPadding(.leading, Constants.safeLeading)
        }
		.background(Color.ypWhite)
    }

    private var bioContent: some View {
        VStack(spacing: Constants.bioSpacing) {
            UserInfo(user: user)
                .lineLimit(Constants.profileLineLimit)
                .lineSpacing(Constants.profileLineSpacing)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
                .padding(.trailing, Constants.profileTrailingFix)
            Button(Constants.titleButton, action: openWebsite)
                .buttonStyle(BorderedButtonStyle(
                    font: Font(UIFont.caption1),
                    textColor: .ypBlack,
                    color: Color(.clear)
                ))
        }
        .padding(.trailing, Constants.bioTrailing)
    }

    private var contentButton: some View {
        NFTCollectionRow(user: user) {
            coordinator.open(screen: .userCollection(nftIDs: user.nfts))
        }
        .frame(maxWidth: .infinity)
    }

    private func openWebsite() {
        coordinator.open(screen: .web(url: websiteURL))
    }
}

#Preview("Light") {
    @Previewable @State var coordinator = StatisticCoordinator(rootCoordinator: RootCoordinatorImpl())
    NavigationStack(path: coordinator.navigationPathBinding) {
        UserCard(user: MockData.users[7])
            .tint(.ypBlack)
            .preferredColorScheme(.light)
            .environment(coordinator)
            .navigationDestination(for: Screen.self) { screen in
                switch screen {
                    case let .web(url, isAppearenceEnabled):
                        WebView(url: url, isAppearenceEnabled: isAppearenceEnabled)
                    default:
                        EmptyView()
                }
            }
    }
}

#Preview("Dark") {
    @Previewable @State var coordinator = StatisticCoordinator(rootCoordinator: RootCoordinatorImpl())
    NavigationStack(path: coordinator.navigationPathBinding) {
        UserCard(user: MockData.users[7])
            .tint(.ypBlack)
            .preferredColorScheme(.dark)
            .environment(coordinator)
            .navigationDestination(for: Screen.self) { screen in
                switch screen {
                    case let .web(url, isAppearenceEnabled):
                        WebView(url: url, isAppearenceEnabled: isAppearenceEnabled)
                    default:
                        EmptyView()
                }
            }
    }
}
