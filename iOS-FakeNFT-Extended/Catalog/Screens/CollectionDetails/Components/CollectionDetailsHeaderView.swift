//
//  CollectionDetailsHeaderView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vladimir on 19.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import SwiftUI

struct CollectionDetailsHeaderView: View {

	private let collectionTitle: String
	private let authorName: String
	private let collectionDescription: String
	private let onAuthorTap: () -> Void

	init(
		collectionTitle: String,
		authorName: String,
		collectionDescription: String,
		onAuthorTap: @escaping () -> Void
	) {
		self.collectionTitle = collectionTitle
		self.authorName = authorName
		self.collectionDescription = collectionDescription
		self.onAuthorTap = onAuthorTap
	}

	var body: some View {
		VStack(alignment: .leading, spacing: .zero) {
			VStack(alignment: .leading, spacing: DesignSystem.Spacing.small) {
				Text(collectionTitle)
					.font(DesignSystem.Font.headline3)
					.foregroundStyle(.ypBlack)
				authorDetails
			}
			Text(collectionDescription)
				.multilineTextAlignment(.leading)
				.font(DesignSystem.Font.caption2)
				.foregroundStyle(.ypBlack)
		}
	}

	private var authorDetails: some View {
		HStack(spacing: DesignSystem.Spacing.xsmall) {
			Text("Author of the collection" + ":")
				.font(DesignSystem.Font.caption2)
				.foregroundStyle(.ypBlack)
			Button(action: onAuthorTap) {
				Text(authorName)
					.font(DesignSystem.Font.caption1)
					.foregroundStyle(.ypUBlue)
			}
		}
	}

}

// MARK: - Preview
#Preview {
	CollectionDetailsHeaderView(
		collectionTitle: "Some collection",
		authorName: "John Doe",
		collectionDescription: "1234567890qwertyuiopasdfghjklzxcvbnm1234567890qwertyuiopasdfghjklzxcvbnm",
		onAuthorTap: { print("tap") }
	)
	.frame(width: 300)
}
