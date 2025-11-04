//
//  NFTCollectionRow.swift
//  iOS-FakeNFT-Extended
//
//  Created by Алина on 18.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//
import SwiftUI

struct NFTCollectionRow: View {

    private enum Constants {
        static let verticalPadding: CGFloat = 16
        static let horizontalPadding: CGFloat = 16
        static let chevronSize: CGFloat = 13
    }

    let user: User
    let onTap: () -> Void

    private var count: Int { user.nfts.count }
    private var hasNFTs: Bool { count > 0 }

    var body: some View {
        Button(action: {
            guard hasNFTs else { return }
            onTap()
        }, label: {
            rowContent
        })
        .buttonStyle(.plain)
        .contentShape(Rectangle())
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets())
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Коллекция NFT, \(count) шт.")
        .accessibilityAddTraits(.isButton)
    }

    private var rowContent: some View {
        Text("Коллекция NFT  (\(count))")
            .font(Font(UIFont.bodyBold))
            .foregroundStyle(.ypBlack)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, Constants.verticalPadding)
            .background(Color.clear)
            .overlay(alignment: .trailing) {
                chevronIcon
                    .padding(.trailing, 16)
            }
    }

    private var chevronIcon: some View {
        Image(systemName: "chevron.right")
            .foregroundColor(.ypBlack)
            .font(.system(size: Constants.chevronSize, weight: .medium))
    }
}

#Preview("NFTCollectionRow") {
    let onTap = {}
    NavigationStack {
        NFTCollectionRow(user: MockData.users[7], onTap: onTap)
    }
    .padding(.top, 250)
    .padding(.leading, 16)
}
