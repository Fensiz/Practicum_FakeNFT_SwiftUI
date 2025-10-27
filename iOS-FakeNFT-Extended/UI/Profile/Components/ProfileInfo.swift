//
//  ProfileInfo.swift
//  iOS-FakeNFT-Extended
//
//  Created by Hajime4life on 12.10.2025.
//

import SwiftUI

struct ProfileInfo: View {
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
		ProfileInfo(user: User(
			id: "sdfsd",
			name: "Joaquin Phoenix",
			avatar: URL(string: "https://tinyurl.com/mrxzhdb7") ?? nil,
			nfts: [],
			rating: "4.5",
			description: "Дизайнер из Казани, люблю цифровое искусство и бейглы.",
			website: nil)
		)
		.padding(.horizontal)
	}
}
