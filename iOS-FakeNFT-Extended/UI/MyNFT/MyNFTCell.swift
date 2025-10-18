//
//  FavoriteNFTCell.swift
//  iOS-FakeNFT-Extended
//
//  Created by Hajime4life on 15.10.2025.
//

import SwiftUI

struct MyNFTCell: View {
    var body: some View {
        HStack(spacing: 0) {
            AsyncImage(url: URL(string: "https://i.yapx.ru/a4wfK.png")!) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 108, height: 108)
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
                    Text("ОТ")
                        .foregroundColor(.ypBlack)
                        .font(Font(UIFont.caption1))
                    Text("John Doe")
                        .foregroundColor(.ypBlack)
                        .font(Font(UIFont.caption2))
                }
            }
            .padding(.leading, 20)
            Spacer()
            VStack(alignment: .leading, spacing: 2) {
                Text("Цена")
                    .font(Font(UIFont.caption2))
                Text("1,78 ETH")
                    .font(Font(UIFont.bodyBold))
            }
            .foregroundColor(.ypBlack)
        }
    }
}

#Preview {
    LightDarkPreviewWrapper {
        MyNFTCell()
            .padding(.horizontal)
    }
}
