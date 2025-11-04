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
			VStack(alignment: .leading, spacing: 8) {
				Text(collectionTitle)
					.font(.system(size: 22, weight: .bold))
					.foregroundStyle(.ypBlack)
				authorDetails
			}
			Text(collectionDescription)
				.multilineTextAlignment(.leading)
				.font(.system(size: 13, weight: .regular))
				.foregroundStyle(.ypBlack)
		}
	}

	private var authorDetails: some View {
		HStack(spacing: 4) {
			Text("Author of the collection" + ":")
				.font(.system(size: 13, weight: .regular))
				.foregroundStyle(.ypBlack)
			Button(action: onAuthorTap) {
				Text(authorName)
					.font(.system(size: 15, weight: .regular))
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
