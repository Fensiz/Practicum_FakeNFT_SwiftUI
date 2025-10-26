//
//  UsersService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Алина on 26.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//
import Foundation

protocol UsersService: Actor {
    func loadUsers() async throws -> [User]
}

final actor UsersServiceImpl: UsersService {
    private let networkClient: any NetworkClient

    init(networkClient: any NetworkClient) {
        self.networkClient = networkClient
    }

    func loadUsers() async throws -> [User] {
        try await networkClient.send(request: UsersRequest())
    }
}
