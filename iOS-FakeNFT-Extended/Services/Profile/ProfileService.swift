//
//  ProfileService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Hajime4life on 14.10.2025.
//

import Foundation

// MARK: - Requests
struct ProfileRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/profile/1")
    }
    var httpMethod: HttpMethod
    var dto: (any Encodable)?
}

// MARK: - Service
@MainActor
final class ProfileServiceImpl: ProfileService {
    private let networkClient: any NetworkClient
    init(networkClient: any NetworkClient) {
        self.networkClient = networkClient
    }
    
    /// получить профиль
    func loadProfile() async throws -> User {
        let request = ProfileRequest(httpMethod: .get)
        return try await networkClient.send(request: request)
    }
    
    /// обновляем только профиль, без лайков
    func saveProfile(_ user: User) async throws -> User {
        let dto = ProfileUpdateDTO(
            name: user.name,
            avatar: user.avatar?.absoluteString,
            description: user.description,
            website: user.website?.absoluteString,
            likes: nil
        )
        let request = ProfileRequest(httpMethod: .put, dto: dto)
        return try await networkClient.send(request: request)
    }
    
    /// проверка на изменения пользователя
    func hasChanges(original: User, current: User) -> Bool {
        original != current
    }
    
    /// для обновления только состояния лайкнутых nft
    func updateLikes(to likes: [String]) async throws -> User {
        let dto = ProfileUpdateDTO(
            name: nil,
            avatar: nil,
            description: nil,
            website: nil,
            likes: likes
        )
        let request = ProfileRequest(httpMethod: .put, dto: dto)
        return try await networkClient.send(request: request)
    }
}
