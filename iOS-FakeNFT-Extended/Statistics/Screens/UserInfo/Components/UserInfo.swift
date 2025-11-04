//
//  UserInfo.swift
//  iOS-FakeNFT-Extended
//
//  Created by Алина on 02.11.2025.
//  Copyright © 2025 com.example. All rights reserved.
//
import SwiftUI

struct UserInfo: View {
	let user: User
	var body: some View {
		VStack(alignment: .leading, spacing: 20) {
			HStack(spacing: 16) {
				AvatarView(imageURL: user.avatar)
				Text(user.name)
					.foregroundColor(.ypBlack)
					.font(DesignSystem.Font.headline3)
			}
			Text(user.description ?? "")
				.font(DesignSystem.Font.caption2)
				.foregroundColor(.ypBlack)
		}
	}
}
