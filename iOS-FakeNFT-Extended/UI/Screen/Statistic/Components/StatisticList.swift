//
//  StatisticList.swift
//  iOS-FakeNFT-Extended
//
//  Created by Алина on 11.10.2025.
//
import SwiftUI

struct StatisticList: View {

    enum SortOption: String, CaseIterable, Sendable {
        case byName
        case byRating
    }

    let users: [User]
    let sortOption: SortOption

    var body: some View {
        List {
            ForEach(Array(users.enumerated()), id: \.1.id) { index, user in
                UserRatingCell(ranking: index + 1, user: user)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
            }
        }
        .listStyle(.plain)
        .scrollIndicators(.hidden)
        .safeAreaPadding(EdgeInsets(top: 20, leading: 16, bottom: 0, trailing: 16))
        .animation(.easeInOut, value: sortOption)
    }
}

#Preview("By Rating") {
    StatisticList(
        users: MockData.users.sorted { $0.ratingValue > $1.ratingValue },
        sortOption: .byRating
    )
}
#Preview("By Name") {
    StatisticList(
        users: MockData.users.sorted { $0.name < $1.name },
        sortOption: .byName)
}
