//
//  RatingView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 05.10.2025.
//

import SwiftUI

struct RatingView: View {
	let rating: Int
	init(_ rating: Int) {
		self.rating = max(0, min(5, rating))
	}
	var body: some View {
		HStack(spacing: 2) {
			ForEach(1...5, id: \.self) { index in
				Image(.star)
					.foregroundStyle(index <= rating ? .ypUYellow : .ypLightGrey)
					.frame(width: 12, height: 12)
			}
		}
	}
}

#Preview {
	LightDarkPreviewWrapper {
		VStack(spacing: 0) {
			RatingView(0)
			RatingView(2)
			RatingView(5)
			RatingView(5).border(.ypBlack)
		}
	}
}
