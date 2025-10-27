//
//  BasicImage.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vladimir on 26.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import SwiftUI
import Kingfisher

struct BasicImage: View {

	@State private var shouldUseErrorImage = false

	private let imageURL: URL?
	private let contentMode: SwiftUICore.ContentMode

	var body: some View {
		if shouldUseErrorImage {
			errorImage
		} else {
			kfImage
		}
	}

	private var kfImage: some View {
		KFImage(imageURL)
			.resizable()
			.placeholder { progress in
				placeholder(progressFraction: progress.fractionCompleted)
			}
			.onFailure { _ in
				// onFailureImage not working
				shouldUseErrorImage = true
			}
			.aspectRatio(contentMode: contentMode)
	}

	private func placeholder(progressFraction: Double) -> some View {
		VStack(spacing: .zero) {
			Spacer()
			ProgressView(value: progressFraction)
				.tint(.ypBlack)
			Spacer()
		}
	}

	private var errorImage: some View {
		Image(systemName: "exclamationmark.triangle.fill")
			.resizable()
			.scaledToFit()
			.foregroundStyle(.ypBlack)
	}

	init(imageURL: URL?, contentMode: SwiftUICore.ContentMode = .fit) {
		self.imageURL = imageURL
		self.contentMode = contentMode
	}

}

// MARK: - Preview

#Preview("Error Image") {
	BasicImage(imageURL: URL(string: ""))
		.frame(width: 300, height: 300)
		.border(.red)
}

#Preview("Normal Image") {
	BasicImage(
		imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Обложки_коллекций/White.png"),
		contentMode: .fit
	)
		.frame(width: 300, height: 300)
		.border(.red)
}
