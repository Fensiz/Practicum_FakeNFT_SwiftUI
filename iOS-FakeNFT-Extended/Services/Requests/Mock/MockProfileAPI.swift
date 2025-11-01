//
//  MockProfileAPI.swift
//  iOS-FakeNFT-Extended
//
//  Created by Алина on 01.11.2025.
//  Copyright © 2025 com.example. All rights reserved.
//
import Foundation
/// код используется как заглушка, при мердже будет использован реальный сервис профиля
enum MockProfileAPI {
    struct ProfileRequest: NetworkRequest {
        var endpoint: URL? { URL(string: "\(RequestConstants.baseURL)\(API.Profile.byId(profileId))") }
        var httpMethod: HttpMethod
        let dto: Data?
        private let profileId: String

        init(profileId: String, httpMethod: HttpMethod, dto: Data? = nil) {
            self.profileId = profileId
            self.httpMethod = httpMethod
            self.dto = dto
        }
    }

    // ProfileFormRequest (PUT)
    struct ProfileFormRequest: NetworkRequest {
        let endpoint: URL?
        let httpMethod: HttpMethod = .put
        let dto: Data?

        init(profileId: String, dto: Data?) {
            var comps = URLComponents(string: RequestConstants.baseURL)
            comps?.path = API.Profile.byId(profileId)
            self.endpoint = comps?.url
            self.dto = dto
        }
    }
}

extension MockProfileAPI.ProfileRequest {
    static func get(profileId: String) -> Self {
        .init(profileId: profileId, httpMethod: .get)
    }
}

extension MockProfileAPI.ProfileFormRequest {
    static func putLikes(profileId: String, likes: [String]) -> Self {
        let value = likes.isEmpty ? "null" : likes.joined(separator: ",")
        let params = ["likes": value]
        return .init(profileId: profileId, dto: params.percentEncoded())
    }
}
