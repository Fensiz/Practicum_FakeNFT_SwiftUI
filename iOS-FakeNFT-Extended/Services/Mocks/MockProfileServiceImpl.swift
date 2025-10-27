//
//  MockProfileServiceImpl.swift
//  iOS-FakeNFT-Extended
//
//  Created by Hajime4life on 24.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

class MockProfileServiceImpl: ProfileService {
    let testUser = User(id: "asd", name: "Test", avatar: nil, nfts: [])
    func loadProfile() async throws -> User {
        testUser
    }
    
    func saveProfile(_ user: User) async throws -> User {
        testUser
    }
    
    func hasChanges(original: User, current: User) -> Bool {
        false
    }
    
    func updateLikes(to likes: [String]) async throws -> User {
        testUser
    }
    
}

