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
	@ObservationIgnored private let profileService: any ProfileService
	private let nftService: any NftService
	private(set) var user: User?
	private(set) var editingUser: User?
	private(set) var isSaveInProgress: Bool = false
	private(set) var myNfts: [NftEntity]? = []
	private(set) var likedNfts: [NftEntity]? = []
	private(set) var errorMessage: String?
	private(set) var isLoadingMyNFTs = false
	private(set) var isLoadingLikedNFTs = false
	var wantToSortMyNft: Bool = false
	init(profileService: any ProfileService, nftsService: any NftService) {
		self.profileService = profileService
		self.nftService = nftsService
	}
	func showSortContextMenu() {
		wantToSortMyNft = true
	}
	func clearError() {
		errorMessage = nil
	}
	func loadProfile() async {
		do {
			self.user = try await profileService.loadProfile()
			self.editingUser = user
		} catch {
			print("❌ Failed to load profile: \(error)")
			self.errorMessage = "Не удалось получить данные"
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
		isLoadingMyNFTs = true
		defer { isLoadingMyNFTs = false }
		
		do {
			self.myNfts = try await loadNfts(for: user.nfts)
			errorMessage = nil
		} catch {
			errorMessage = "Не удалось получить данные"
		}
	}
	func loadLikedNFTs() async {
		guard let user = user, let likes = user.likes, !likes.isEmpty else {
			errorMessage = "Нет лайкнутых NFT"
			return
		}
		isLoadingLikedNFTs = true
		defer { isLoadingLikedNFTs = false }
		do {
			self.likedNfts = try await loadNfts(for: likes)
			errorMessage = nil
		} catch {
			errorMessage = "Не удалось получить данные о лайках"
		}
	}
	func saveProfile() async {
		guard let editingUser = editingUser else { return }
		isSaveInProgress = true
		errorMessage = nil
		defer { isSaveInProgress = false }
		do {
			let updatedUser = try await profileService.saveProfile(editingUser)
			self.user = updatedUser
			self.editingUser = updatedUser
		} catch {
			print("❌ Ошибка сохранения профиля: \(error)")
			errorMessage = "Не удалось сохранить профиль"
		}
	}
	func updateProfile(with data: ProfileEditData) async {
		guard var editingUser = editingUser else { return }
		editingUser.name = data.name
		editingUser.description = data.description.isEmpty ? nil : data.description
		editingUser.website = URL(string: data.website)
		editingUser.avatar = data.avatarURL
		self.editingUser = editingUser
		await saveProfile()
	}
	func cancelEditing() {
		editingUser = user
		errorMessage = nil
	}
	func isLiked(nftId: String) -> Bool {
		user?.likes?.contains(nftId) == true
	}
	func toggleLike(nftId: String) async {
		guard var likes = user?.likes else { return }
		
		if likes.contains(nftId) {
			likes.removeAll { $0 == nftId }
		} else {
			likes.append(nftId)
		}
		
		do {
			let updatedUser = try await profileService.updateLikes(to: likes)
			self.user = updatedUser
			await loadMyNFTs()
		} catch {
			await MainActor.run {
				errorMessage = "Не удалось обновить лайк"
			}
		}
	}
	func sortMyNFTs(by criteria: SortCriteria) {
		guard var nfts = myNfts else { return }
		switch criteria {
		case .price:
			nfts.sort { $0.price < $1.price }
		case .rating:
			nfts.sort { $0.rating > $1.rating }
		case .name:
			nfts.sort { $0.name < $1.name }
		}
		self.myNfts = nfts
	}
	enum SortCriteria {
		case price, rating, name
	}
}
