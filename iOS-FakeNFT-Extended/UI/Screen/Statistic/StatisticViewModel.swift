//
//  StatisticViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Алина on 14.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//
import Foundation
import Observation

@MainActor
@Observable
final class StatisticViewModel {

    var users: [User] = []
    private(set) var sortOption: StatisticList.SortOption = .byRating
    private let usersService: any UsersService
    private(set) var isLoading = false
    private(set) var errorMessage: String?

    var sortedUsers: [User] {
        switch sortOption {
            case .byName: users.sorted { $0.name < $1.name }
            case .byRating: users.sorted { $0.ratingValue > $1.ratingValue }
        }
    }

    init(usersService: any UsersService) {
        self.usersService = usersService
    }

    func makeLoad() async {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            try Task.checkCancellation()
            users = try await usersService.loadUsers()
        } catch is CancellationError {
            // тихо выходим
        } catch let error as NetworkClientError {
//            errorMessage = getErrorMessage(for: error)
        } catch {
            errorMessage = "Неизвестная ошибка: \(error.localizedDescription)"
        }
    }

    func makeSetSort(_ option: StatisticList.SortOption) {
        sortOption = option
    }
}
