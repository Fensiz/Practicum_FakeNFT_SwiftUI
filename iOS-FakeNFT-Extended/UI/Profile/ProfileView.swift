//
//  ProfileView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Герман on 10.10.2025.
//

import SwiftUI

struct ProfileView: View {
    let viewModel: ProfileViewModel
    var body: some View {
        VStack(alignment: .leading) {
            if let user = viewModel.user {
                ProfileInfo(user: user)
                
                if let website = user.website {
                    Text(website.absoluteString)
                        .lineLimit(1)
                        .foregroundColor(.ypUBlue)
                        .padding(.top, 8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                navButton(title: "Мои NFT", count: user.nfts.count)
                    .padding(.top, 40)
                navButton(title: "Избранные NFT", count: user.likes?.count ?? 0)
                Spacer()
            } else {
                ProgressView() // TODO: Заменить на LoadingView(), добавить стейты
            }
        }
        .padding(.horizontal)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if let user = viewModel.user { // TODO: Заменить на стейт
                    // TODO: Добавить переход на редактирование
                    Button(action: { print("Edit Tapped!") }) {
                        Image(systemName: "square.and.pencil")
                            .resizable()
                            .frame(width: 26.5, height: 26.5)
                    }
                    .foregroundColor(.ypBlack)
                }
            }
        }
        .toolbarRole(.editor)
        .background(Color.ypWhite)
        .task {
            await viewModel.loadProfile()
        }
    }
    // MARK: - SubViews:
    @ViewBuilder
    private func navButton(title: String, count: Int) -> some View {
        Button(action: { print("Navigate to List") }) {
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

#Preview {
    NavigationStack {
        ProfileView(
            viewModel: ProfileViewModel(
                profileService: ProfileServiceImpl(networkClient: DefaultNetworkClient()
                )
            )
        )
    }
}
