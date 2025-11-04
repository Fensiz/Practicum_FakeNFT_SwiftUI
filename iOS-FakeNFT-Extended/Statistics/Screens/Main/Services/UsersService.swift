//
//  UsersService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Алина on 26.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//
import Foundation

protocol UsersService: Actor {
	func loadUsers(page: Int, size: Int, sortBy: String?) async throws -> [User]
	func loadUser(by id: String) async throws -> User
	func loadUserIDs(page: Int, size: Int, sortBy: String?) async throws -> [String]
}

final actor UsersServiceImpl: UsersService {
	private let networkClient: any NetworkClient
	
	init(networkClient: any NetworkClient) {
		self.networkClient = networkClient
	}
	
	func loadUsers(page: Int, size: Int, sortBy: String?) async throws -> [User] {
		let request = UsersRequest(page: page, size: size, sortBy: sortBy)
		return try await networkClient.send(request: request)
	}
	
	func loadUser(by id: String) async throws -> User {
		try await networkClient.send(request: UserByIDRequest(userID: id))
	}
	
	func loadUserIDs(page: Int, size: Int, sortBy: String?) async throws -> [String] {
		let users = try await loadUsers(page: page, size: size, sortBy: sortBy)
		return users.map { $0.id }
	}
}
