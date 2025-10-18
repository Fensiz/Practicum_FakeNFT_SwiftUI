//
//  FavoriteNFTCell.swift
//  iOS-FakeNFT-Extended
//
//  Created by Hajime4life on 18.10.2025.
//

import SwiftUI

struct FavoriteNFTCell: View {
    var body: some View {
        HStack(spacing: 0) {
            AsyncImage(url: URL(string: "https://i.yapx.ru/a4wfK.png")!) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
                    .cornerRadius(12)
            } placeholder: {}
            .aspectRatio(contentMode: .fit)
            VStack(alignment: .leading, spacing: 5) {
                Text("April")
                    .foregroundColor(.ypBlack)
                    .font(Font(UIFont.bodyBold))
                HStack(spacing: 2) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.ypUYellow)
                    Image(systemName: "star.fill")
                        .foregroundColor(.ypUYellow)
                    Image(systemName: "star.fill")
                        .foregroundColor(.ypUYellow)
                    Image(systemName: "star.fill")
                        .foregroundColor(.ypLightGrey)
                    Image(systemName: "star.fill")
                        .foregroundColor(.ypLightGrey)
                }
                HStack(spacing: 4) {
                    Text("1,78 ETH")
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
        FavoriteNFTCell()
            .padding(.horizontal)
    }
}
