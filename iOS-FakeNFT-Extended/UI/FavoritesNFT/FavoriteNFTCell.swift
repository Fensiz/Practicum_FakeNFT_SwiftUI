//
//  FavoriteNFTCell.swift
//  iOS-FakeNFT-Extended
//
//  Created by Hajime4life on 18.10.2025.
//

import SwiftUI
import Kingfisher

struct FavoriteNFTCell: View {
    let nft: NftEntity
    let onLikeTap: () -> Void
    var body: some View {
        HStack(spacing: 0) {
            KFImage(nft.imageURLs.first)
                .placeholder {
                    Color.gray.opacity(0.3)
                }
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
                .cornerRadius(12)
                .aspectRatio(contentMode: .fit)
                .overlay(alignment: .topTrailing) {
                    Image(.active)
                        .foregroundColor(.ypURed)
                        .onTapGesture(perform: onLikeTap)
                        .offset(x: 5, y: -5)
                }
            VStack(alignment: .leading, spacing: 5) {
                Text(nft.name)
                    .foregroundColor(.ypBlack)
                    .font(Font(UIFont.bodyBold))
                RatingView(nft.rating)
                HStack(spacing: 4) {
                    Text("\(String(format: "%.2f", nft.price)) ETH")
                        .foregroundColor(.ypBlack)
                        .font(Font(UIFont.caption1))
                }
            }
            .padding(.leading, 20)
        }
    }
}

#Preview {
    LightDarkPreviewWrapper {
        FavoriteNFTCell(
            nft: NftEntity(
                id: "1",
                name: "April",
                images: [URL(string: "https://i.yapx.ru/a4wfK.png")!],
                rating: 4,
                descriptionText: "Description",
                price: 1.78,
                authorURL: URL(string: "https://example.com")!
            ),
            onLikeTap: {}
        )
        .padding(.horizontal)
    }
}
