//
//  NFTCollectionCell.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vladimir on 15.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import SwiftUI

struct NFTCollectionCellView: View {

    private let model: NFTCollectionModel

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            image
                .frame(height: 140)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            title
        }
        .padding(.bottom, 13)
    }

    private var image: some View {
        AsyncImage(url: model.imageURL) { image in
            image
                .resizable()
                .scaledToFill()
                .clipped()
        } placeholder: {
            Color.ypUGrey
                .overlay {
                    ProgressView()
                        .tint(.ypUWhite)
                }
        }
    }

    private var title: some View {
        HStack(spacing: 4) {
            Group {
                Text("\(model.title.capitalized)")
                Text("(\(model.nfts.count))")
            }
            .font(.system(size: 17, weight: .bold))
            .foregroundStyle(.ypBlack)
        }
    }

    init(collection: NFTCollectionModel) {
        self.model = collection
    }

}

#Preview {
	NFTCollectionCellView(
		collection: .init(
			id: UUID(),
			title: "unum reque",
			imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Обложки_коллекций/White.png")!,
			nfts: [],
			description: "dictas ...",
			author: .init(
				id: UUID(),
		  name: "Jimmie Reilly",
		  description: "daddsd",
		  nfts: [],
		  websiteURL: URL(string: "https://student7.students.practicum.org")!,
		  avatarURL: URL(string: "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/594.jpg")!
	  )
		)
	)
	.frame(width: 300, height: 500)
}
