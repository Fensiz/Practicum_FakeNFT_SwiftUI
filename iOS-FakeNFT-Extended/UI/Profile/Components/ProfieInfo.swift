//
//  ProfieInfo.swift
//  iOS-FakeNFT-Extended
//
//  Created by Hajime4life on 12.10.2025.
//

import SwiftUI

struct ProfieInfo: View {
    let user: User
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(spacing: 16) {
                ProfileImage(imageUrl: user.avatar)
                Text(user.name)
                    .foregroundColor(.ypBlack)
                    .font(Font(UIFont.headline3))
            }
           Text(user.description ?? "")
                .font(Font(UIFont.caption2))
                .foregroundColor(.ypBlack)
        }
    }
}

#Preview {
LightDarkPreviewWrapper {
    ProfieInfo(user:
        User(
            id: "dsfsd",
            name: "",
            avatar: URL(string: "https://i.ibb.co/fVLFtWrM/c1f8f42c5f5bd684e27d93131dc6ffd4696cdfd3.jpg") ?? nil,
            nfts: [],
            rating: "4.5"
            )
        )
        .padding(.horizontal)
    }
}
