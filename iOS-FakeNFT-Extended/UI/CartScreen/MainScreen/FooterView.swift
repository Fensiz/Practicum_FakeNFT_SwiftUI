//
//  FooterView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 12.10.2025.
//

import SwiftUI

struct FooterView: View {
	let totalCount: Int
	let totalPrice: Double
	let payAction: () -> Void

	var body: some View {
		Color.ypLightGrey
			.frame(height: 76)
			.clipShape(.rect(
				topLeadingRadius: 16,
				bottomLeadingRadius: 0,
				bottomTrailingRadius: 0,
				topTrailingRadius: 16
			))
			.overlay {
				HStack {
					VStack(alignment: .leading) {
						Text("\(totalCount) NFT")
							.font(.system(size: 17, weight: .regular))
							.foregroundStyle(.ypBlack)
							.lineLimit(1)
						HStack(spacing: 0) {
							Text(String(format: "%.2f", totalPrice).replacingOccurrences(of: ".", with: ","))
							Text(" ETH")
						}
						.font(.system(size: 17, weight: .bold))
						.foregroundStyle(.ypUGreen)
						.lineLimit(1)
					}
					.frame(maxWidth: .infinity, alignment: .leading)
					Button("К оплате", action: payAction)
						.buttonStyle(PrimaryButtonStyle())
						.frame(width: 240, height: 44)
				}
				.padding(.horizontal, 16)
			}
	}
}
