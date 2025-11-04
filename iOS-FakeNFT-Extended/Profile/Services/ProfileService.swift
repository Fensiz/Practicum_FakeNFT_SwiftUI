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
	let dto: Data?

	init(httpMethod: HttpMethod, dto: Data? = nil) {
		self.httpMethod = httpMethod
		self.dto = dto
	}
}

struct ProfileFormRequest: NetworkRequest {
	let endpoint: URL?
	let httpMethod: HttpMethod = .put
	let dto: Data?
}

// MARK: - Servic
@MainActor
final class ProfileServiceImpl: ProfileService {
	private let networkClient: any NetworkClient
	init(networkClient: any NetworkClient) {
		self.networkClient = networkClient
	}
	func loadProfile() async throws -> User {
		let request = ProfileRequest(httpMethod: .get)
		return try await networkClient.send(request: request)
	}
	func saveProfile(_ user: User) async throws -> User {
		let dto = ProfileUpdateDTO(
			name: user.name,
			avatar: user.avatar?.absoluteString,
			description: user.description,
			website: user.website?.absoluteString,
			likes: nil
		)

		guard let formData = dto.toFormURLEncoded(),
			  let url = URL(string: "\(RequestConstants.baseURL)/api/v1/profile/1") else {
			throw URLError(.badURL)
		}

		let request = ProfileFormRequest(endpoint: url, dto: formData)
		return try await networkClient.send(request: request)
	}
	func hasChanges(original: User, current: User) -> Bool {
		original != current
	}
	func updateLikes(to likes: [String]) async throws -> User {
		let dto = ProfileUpdateDTO(
			name: nil,
			avatar: nil,
			description: nil,
			website: nil,
			likes: likes
		)

		guard let formData = dto.toFormURLEncoded() else {
			throw URLError(.badURL)
		}

		let request = ProfileRequest(httpMethod: .put, dto: formData)
		return try await networkClient.send(request: request)
	}
}

extension Array where Element == String {
	var urlEncodedLikes: String {
		self.isEmpty ? "[]" : self.joined(separator: ",")
	}
}
