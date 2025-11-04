//
//  ProfileImage.swift
//  iOS-FakeNFT-Extended
//
//  Created by Герман on 11.10.2025.
//

import SwiftUI
import Kingfisher

struct AvatarView: View {
	let imageURL: URL?
	let showBadge: Bool

	init(imageURL: URL?, showBadge: Bool = false) {
		self.imageURL = imageURL
		self.showBadge = showBadge
	}

	var body: some View {
		KFImage(imageURL)
			.onFailureImage(.emtpyAvatar)
			.placeholder {
				ProgressView()
					.scaleEffect(1.5)
					.progressViewStyle(
						CircularProgressViewStyle(
							tint: DesignSystem.Color.background
						)
					)
					.frame(
						width: DesignSystem.Sizes.imageMedium2,
						height: DesignSystem.Sizes.imageMedium2
					)
					.background(DesignSystem.Color.primary)
			}
			.resizable()
			.scaledToFill()
			.frame(
				width: DesignSystem.Sizes.imageMedium2,
				height: DesignSystem.Sizes.imageMedium2
			)
			.clipShape(Circle())
			.overlay(alignment: .topLeading) {
				if showBadge {
					Circle()
						.fill(DesignSystem.Color.backgroundSecondary)
						.frame(
							width: DesignSystem.Sizes.imageSmall2,
							height: DesignSystem.Sizes.imageSmall2
						)
						.overlay {
							Image(.camera)
								.foregroundStyle(DesignSystem.Color.primary)
						}
						.offset(x: 50, y: 47)
				}
			}
	}
}

#Preview {
	let validUrl = URL(string: "https://tinyurl.com/mrxzhdb7")
	let notValidUrl = URL(string: "https://not_valid")
	AvatarView(imageURL: validUrl, showBadge: false)
	AvatarView(imageURL: validUrl, showBadge: true)
	AvatarView(imageURL: notValidUrl, showBadge: true)
	AvatarView(imageURL: nil, showBadge: true)
}
