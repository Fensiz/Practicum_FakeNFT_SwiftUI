//
//  ProfileView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Герман on 10.10.2025.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack {
            HStack(spacing: 16) {
                // TODO: Заменить на фото профиля
                Circle()
                    .frame(width: 70)
                Text("Joaquin Phoenix")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(Font(UIFont.headline3))
                    .foregroundColor(.ypUBlack)
            }
            Group {
                Text("Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям.")
                    .foregroundColor(.ypUBlack)
                    .padding(.top, 20)
                Text("Joaquin Phoenix.com")
                    .foregroundColor(.ypUBlue)
                    .padding(.top, 8)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            navButton(title: "Мои NFT", count: 112)
                .padding(.top, 40)
            navButton(title: "Избранные NFT", count: 11)
            Spacer()
        }
        .padding(.horizontal)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                // TODO: Добавить переход на редактирование
                Button(action: { print("Edit Tapped!") }) {
                    Image(systemName: "square.and.pencil")
                    .resizable()
                    .frame(width: 26.5, height: 26.5)
                }
                .foregroundColor(.ypBlack)
            }
        }
        .toolbarRole(.editor)
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
    NavigationView {
        ProfileView()
    }
}
