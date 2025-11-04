//
//  UserRatingCell.swift
//  iOS-FakeNFT-Extended
//
//  Created by Алина on 11.10.2025.
//
import Kingfisher
import SwiftUI

struct UserRatingCell: View {
	private enum Constants {
		static let placeholder = "person.crop.circle.fill"
	}

	let ranking: Int
	let user: User

	var body: some View {
		HStack(spacing: DesignSystem.Spacing.small) {
			placeRatingLabel
			cardStatistics
				.clipShape(
					RoundedRectangle(cornerRadius: DesignSystem.Radius.small, style: .continuous)
				)
				.background(
					RoundedRectangle(cornerRadius: DesignSystem.Radius.small, style: .continuous)
						.fill(Color.ypLightGrey)
				)
		}
		.frame(maxWidth: .infinity, minHeight: DesignSystem.Sizes.elementLargeHeight)
		.background(Color.clear)
	}

	private var placeRatingLabel: some View {
		StatisticLabel(
			text: "\(ranking)",
			font: DesignSystem.Font.caption1,
			maxWidth: DesignSystem.Sizes.elementXSmallWidth,
			maxHeight: DesignSystem.Sizes.elementLargeHeight)
		.background(Color.clear)
		.clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.small))
	}

	private var cardStatistics: some View {
		HStack {
			avatarView
			StatisticLabel(
				text: "\(user.name)",
				font: DesignSystem.Font.headline3
			)
			Spacer()
			StatisticLabel(
				text: "\(user.ratingValue)",
				font: DesignSystem.Font.headline3
			)
		}
		.frame(maxWidth: .infinity, maxHeight: DesignSystem.Sizes.elementLargeHeight)
		.padding(.horizontal, DesignSystem.Padding.medium)
	}

	@ViewBuilder
	private var avatarView: some View {
		let placeholder = Image(systemName: Constants.placeholder)
			.resizable()
			.aspectRatio(contentMode: .fill)
			.frame(width: DesignSystem.Sizes.imageSmall3, height: DesignSystem.Sizes.imageSmall3)
			.clipShape(Circle())
			.foregroundStyle(.ypUGrey)

		if let url = user.avatar {
			KFImage(url)
				.placeholder { placeholder }
				.resizable()
				.aspectRatio(contentMode: .fill)
				.frame(width: DesignSystem.Sizes.imageSmall3, height: DesignSystem.Sizes.imageSmall3)
				.clipShape(Circle())
		} else {
			placeholder
		}
	}
}

// MARK: - Preview
struct UserRatingCell_Previews: PreviewProvider {
	static var previews: some View {
		VStack(spacing: 8) {
			UserRatingCell(ranking: 1, user: MockData.users[6])
			UserRatingCell(ranking: 2, user: MockData.users[4])
			UserRatingCell(ranking: 3, user: MockData.users[0])
		}
		.padding()
		.background(Color(.systemBackground))
		.previewLayout(.sizeThatFits)
		.previewDisplayName("UserRatingCell Preview")
		.preferredColorScheme(.dark)
	}
}
