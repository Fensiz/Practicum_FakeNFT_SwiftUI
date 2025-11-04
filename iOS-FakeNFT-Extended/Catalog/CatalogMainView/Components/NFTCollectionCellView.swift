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
		VStack(alignment: .center, spacing: 4) {
			BasicImage(
				imageURL: model.imageURL,
				contentMode: .fill
			)
			.frame(height: 140)
			.clipShape(RoundedRectangle(cornerRadius: 12))
			title
		}
		.padding(.bottom, 13)
	}

    private var title: some View {
        HStack(spacing: 4) {
            Group {
                Text("\(model.title.capitalized)")
                Text("(\(model.nftsCount))")
				Spacer()
            }
            .font(.system(size: 17, weight: .bold))
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
