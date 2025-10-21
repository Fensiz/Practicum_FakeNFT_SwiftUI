import SwiftUI

@MainActor
@Observable
final class ProfileViewModel {
    private let profileService: ProfileServiceImpl
    private(set) var user: User? = nil
    init(profileService: ProfileServiceImpl) {
        self.profileService = profileService
    }
    func loadProfile() async {
        do {
            self.user = try await profileService.loadProfile()
        } catch {
            print("Failed to load profile: \(error)")
        }
    }
}
