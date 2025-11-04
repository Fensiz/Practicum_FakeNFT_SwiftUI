//
//  NFTCollectionCell.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vladimir on 15.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import SwiftUI

struct NFTCollectionCellView: View {

	private let model: NFTCollectionCardModel

	var body: some View {
		VStack(alignment: .center, spacing: DesignSystem.Spacing.xsmall) {
			BasicImage(
				imageURL: model.imageURL,
				contentMode: .fill
			)
			.frame(height: 140)
			.clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.small))
			title
		}
		.padding(.bottom, DesignSystem.Padding.small)
	}

	private var title: some View {
		HStack(spacing: DesignSystem.Spacing.xsmall) {
			Group {
				Text("\(model.title.capitalized)")
				Text("(\(model.nftsCount))")
				Spacer()
			}
			.font(DesignSystem.Font.bodyBold)
			.foregroundStyle(.ypBlack)
		}
	}

	init(collection: NFTCollectionCardModel) {
		self.model = collection
	}

}

#Preview {
	NFTCollectionCellView(
		collection: .init(
			id: UUID(),
			title: "unum reque",
			imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Обложки_коллекций/White.png")!,
			nftsCount: 3
		)
	)
	.frame(width: 300, height: 500)
}
