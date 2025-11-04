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

	private(set) var users: [User] = []
	private(set) var sortOption: StatisticList.SortOption = .byRating

	private(set) var isLoading = false
	private(set) var canLoadMore = true

	private let usersService: any UsersService
	private var currentPage = 0
	private let pageSize = 10
	private var loadedUserIDs = Set<String>()

	var sortedUsers: [User] {
		switch sortOption {
			case .byName: users
			case .byRating: users.sorted { $0.ratingValue > $1.ratingValue }
		}
	}

	init(usersService: any UsersService) {
		self.usersService = usersService
	}

	func makeLoad() async {
		await loadUsers(page: 0, isInitialLoad: true)
	}

	func makeSetSort(_ option: StatisticList.SortOption) {
		if sortOption != option {
			sortOption = option
			Task {
				await reloadWithNewSort()
			}
		}
	}

	func loadNextPage() async {
		guard !isLoading, canLoadMore else {
			return
		}
		currentPage += 1
		await loadUsers(page: currentPage, isInitialLoad: false)
	}

	private func reloadWithNewSort() async {
		loadedUserIDs = []
		currentPage = 0
		canLoadMore = true
		await loadUsers(page: 0, isInitialLoad: true)
	}

	private func getSortByParameter() -> String? {
		return sortOption == .byName ? "name" : nil
	}

	private func loadUsers(page: Int, isInitialLoad: Bool) async {
		guard !isLoading else {
			return
		}

		isLoading = true
		defer {
			isLoading = false
		}

		do {
			let sortBy = getSortByParameter()
			/// Получение id пользователя
			let userIDs = try await usersService.loadUserIDs(page: page, size: pageSize, sortBy: sortBy)

			if userIDs.isEmpty {
				canLoadMore = false
				return
			}
			/// Фильтрация дубликатов
			let newUserIDs = userIDs.filter { !loadedUserIDs.contains($0) }

			if newUserIDs.isEmpty && userIDs.count > 0 {
				currentPage += 1
				await loadUsers(page: currentPage, isInitialLoad: isInitialLoad)
				return
			}
			/// Загрузка каждого пользователя
			var newUsers: [User] = []
			var failedUserIDs: [String] = []

			for userID in newUserIDs {
				do {
					let user = try await usersService.loadUser(by: userID)
					newUsers.append(user)
					loadedUserIDs.insert(userID)
				} catch {
					failedUserIDs.append(userID)
					continue
				}
			}
			/// Обновление данных
			if isInitialLoad {
				users = newUsers
			} else {
				users.append(contentsOf: newUsers)
			}

			canLoadMore = (userIDs.count > 0) && (userIDs.count >= pageSize || newUserIDs.count > 0)

		} catch {
			canLoadMore = true
		}
	}
}
