//
//  PaymentMethodCell.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 12.10.2025.
//

import SwiftUI

struct PaymentMethodCell: View {
	let method: PaymentMethod
	let isSelected: Bool

	var body: some View {
		HStack(spacing: 4) {
			AsyncImage(url: method.image) { image in
				image
					.resizable()
					.aspectRatio(contentMode: .fit)
			} placeholder: {
				ProgressView()
			}
			.background(.black)
			.clipShape(RoundedRectangle(cornerRadius: 6))
			.frame(width: 36, height: 36)
			VStack(alignment: .leading) {
				Text(method.title)
					.foregroundStyle(.ypBlack)
				Text(method.name)
					.foregroundStyle(.ypUGreen)
			}
			.font(.system(size: 13, weight: .regular))
		}
		.frame(maxWidth: .infinity, alignment: .leading)
		.padding(.horizontal, 12)
		.padding(.vertical, 5)
		.background(.ypLightGrey)
		.clipShape(RoundedRectangle(cornerRadius: 12))
		.overlay {
			if isSelected {
				RoundedRectangle(cornerRadius: 12)
					.stroke(.ypBlack, lineWidth: 1)
			}
		}
	}
}
