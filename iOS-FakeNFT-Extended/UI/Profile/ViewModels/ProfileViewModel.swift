//
//  ProfileViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Hajime4life on 22.10.2025.
//

import SwiftUI

@MainActor
@Observable
final class ProfileViewModel: ObservableObject {
    private let profileService: any ProfileService
    private let nftService: any NftService
    private(set) var user: User?
    private(set) var editingUser: User?
    private(set) var isSaveInProgress: Bool = false
    private(set) var myNfts: [NftEntity]? = []
    private(set) var likedNfts: [NftEntity]? = []
    private(set) var errorMessage: String?
//    var wantExitHasChanges: Bool = false
    var wantToSortMyNft: Bool = false
//    var needToShowContextMenu: Bool = false
//    var needToshowSiteEditAlert: Bool = false
//    var shouldShowSaveButton: Bool = false
    var temporaryAvatarUrl: String = ""
    init(profileService: any ProfileService, nftsService: any NftService) {
        self.profileService = profileService
        self.nftService = nftsService
    }
	func showSortContextMenu() {
        wantToSortMyNft = true
    }
//    func showContextMenu() {
//        needToShowContextMenu = true
//    }
//    func hideContextMenu() {
//        needToShowContextMenu = false
//    }
//    func showSiteEditAlert() {
//        temporaryAvatarUrl = editingUser?.avatar?.absoluteString ?? ""
//        needToshowSiteEditAlert = true
//    }
//    func hideSiteEditAlert() {
//        needToshowSiteEditAlert = false
//        temporaryAvatarUrl = ""
//    }
	func clearError() { // TODO: возможно стоит избавиться и перенести на экраны списка
        errorMessage = nil
    }
//    func setAvatarToDefault() {
//        editingUser?.avatar = user?.avatar
//        temporaryAvatarUrl = ""
//    }
//    func applyAvatarUrl() {
//        if let url = URL(string: temporaryAvatarUrl), url.scheme != nil {
//            editingUser?.avatar = url
//        } else {
//            editingUser?.avatar = nil
//        }
//        temporaryAvatarUrl = ""
//
//    }
    func loadProfile() async {
        do {
            self.user = try await profileService.loadProfile()
            self.editingUser = user
//            shouldShowSaveButton = false
        } catch {
            print("Failed to load profile: \(error)")
        }
    }
    private func loadNfts(for ids: [String]) async throws -> [NftEntity] {
        let nftModels = try await withThrowingTaskGroup(of: Nft.self, returning: [Nft].self) { @MainActor group in
            for id in ids {
                group.addTask {
                    try await self.nftService.loadNft(id: id)
                }
            }
            var result: [Nft] = []
            for try await nft in group {
                result.append(nft)
            }
            return result
        }
        return nftModels.map { nft in
            NftEntity(
                id: nft.id,
                name: nft.name,
                images: nft.images,
                rating: nft.rating,
                descriptionText: nft.description,
                price: nft.price,
                authorURL: nft.author
            )
        }
    }
    func loadMyNFTs() async {
        guard let user = user else {
            errorMessage = "Не удалось получить данные"
            return
        }
        do {
            self.myNfts = try await loadNfts(for: user.nfts)
            errorMessage = nil
        } catch {
            errorMessage = "Не удалось получить данные"
        }
    }
    func loadLikedNFTs() async {
        guard let user = user, let likes = user.likes, !likes.isEmpty else {
            errorMessage = "Не удалось получить данные о лайках"
            return
        }
        do {
            self.likedNfts = try await loadNfts(for: likes)
            errorMessage = nil
        } catch {
            errorMessage = "Не удалось получить данные о лайках"
        }
    }

//    func hasChanges() -> Bool {
//        guard let user = user, let editingUser = editingUser else { return false }
//        return user != editingUser
//    }
    func saveProfile() async {
		print("Сохраняю профиль, я во VM")
        // guard let editingUser = editingUser else { return }
        // isSaveInProgress = true
        // defer { isSaveInProgress = false }
        // do {
        //     try await profileService.updateProfile(editingUser)
        //     self.user = editingUser
        //     shouldShowSaveButton = false
        // } catch {
        //     print("Failed to save profile: \(error)")
        // }
    }
	func updateProfile(with data: ProfileEditData) async {
		guard var editingUser = editingUser else { return }
		editingUser.name = data.name
		editingUser.description = data.description.isEmpty ? nil : data.description
		editingUser.website = URL(string: data.website)
		editingUser.avatar = data.avatarURL
		
		self.editingUser = editingUser
//		shouldShowSaveButton = hasChanges()
		
		await saveProfile()
	}
	func setUserToDefault() {
		editingUser = user
//		shouldShowSaveButton = false
	}
	func cancelEditing() {
		setUserToDefault()
	}




}
