//
//  ProfileServiceProtocol.swift
//  iOS-FakeNFT-Extended
//
//  Created by Hajime4life on 14.10.2025.
//

import Foundation

@MainActor
protocol ProfileService {
    func loadProfile() async throws -> User
    func saveProfile(_ user: User) async throws -> User
    func hasChanges(original: User, current: User) -> Bool
    func updateLikes(to likes: [String]) async throws -> User
}
