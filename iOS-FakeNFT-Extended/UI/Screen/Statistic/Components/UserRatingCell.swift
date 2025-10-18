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
        enum Layout {
            static let horizontalSpacing: CGFloat = 8
            static let horizontalPadding: CGFloat = 16
            static let cornerRadius: CGFloat = 12
        }
        enum Sizes {
            static let avatarSize: CGFloat = 28
            static let cellMinHeight: CGFloat = 80
            static let ratingLabelWidth: CGFloat = 27
            static let labelMaxHeight: CGFloat = 80
        }
        enum Images {
            static let placeholder = "person.crop.circle.fill"
        }
    }

    let ranking: Int
    let user: User

    var body: some View {
        HStack(spacing: Constants.Layout.horizontalSpacing) {
            placeRatingLabel
            cardStatistics
                .clipShape(
                    RoundedRectangle(cornerRadius: Constants.Layout.cornerRadius, style: .continuous)
                )
                .background(
                    RoundedRectangle(cornerRadius: Constants.Layout.cornerRadius, style: .continuous)
                        .fill(Color.ypLightGrey)
                )
        }
        .frame(maxWidth: .infinity, minHeight: Constants.Sizes.cellMinHeight)
        .background(Color(.systemBackground))
    }

    private var placeRatingLabel: some View {
        StatisticLabel(
            text: "\(ranking)",
            font: Font(UIFont.caption1),
            maxWidth: Constants.Sizes.ratingLabelWidth,
            maxHeight: Constants.Sizes.labelMaxHeight)
    }

    private var cardStatistics: some View {
        HStack {
            avatarView
            StatisticLabel(text: "\(user.name)", font: Font(UIFont.headline3))
            Spacer()
            StatisticLabel(text: "\(user.ratingValue)",
                           font: Font(UIFont.headline3)
            )
        }
        .frame(maxWidth: .infinity, maxHeight: 80)
        .padding(.horizontal, Constants.Layout.horizontalPadding)
    }

    @ViewBuilder
    private var avatarView: some View {
        let placeholder = Image(systemName: Constants.Images.placeholder)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: Constants.Sizes.avatarSize, height: Constants.Sizes.avatarSize)
            .clipShape(Circle())
            .foregroundStyle(.ypUGrey)

        if let url = user.avatar {
            KFImage(url)
                .placeholder { placeholder }
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: Constants.Sizes.avatarSize, height: Constants.Sizes.avatarSize)
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
