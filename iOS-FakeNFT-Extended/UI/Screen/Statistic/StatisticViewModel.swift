//
//  StatisticViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Алина on 14.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//
import Foundation
import Observation

@Observable
final class StatisticViewModel {

    var users: [User] = []
    private(set) var sortOption: StatisticList.SortOption = .byRating

    var sortedUsers: [User] {
        switch sortOption {
            case .byName: users.sorted { $0.name < $1.name }
            case .byRating: users.sorted { $0.ratingValue > $1.ratingValue }
        }
    }

    init() {
        makeLoad()
    }

    private func makeLoad() {
        users = MockData.users
    }

    func makeSetSort(_ option: StatisticList.SortOption) {
        sortOption = option
    }
}
