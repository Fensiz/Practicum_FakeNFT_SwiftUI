//
//  ProfileCoordinator.swift
//  iOS-FakeNFT-Extended
//
//  Created by Hajime4life on 24.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import SwiftUI

@MainActor
protocol ProfileCoordinator: AnyObject {
	// MARK: - Навигация
	func goBack()
	func openMyNFTs()
	func openLikedNFTs()
	func openProfileEdit()
	func openWebsite(url: URL)
	// MARK: - Covers
	func openUserAgreement()
	// MARK: - Состояние UI
	func showSaveButton()
	func hideSaveButton()
}

final class ProfileCoordinatorImpl: ProfileCoordinator {
	private let rootCoordinator: any RootCoordinator
	private var _shouldShowSaveButton = false
	var shouldShowSaveButton: Bool { _shouldShowSaveButton }
	init(rootCoordinator: any RootCoordinator) {
		self.rootCoordinator = rootCoordinator
	}
	func showSaveButton() { _shouldShowSaveButton = true }
	func hideSaveButton() { _shouldShowSaveButton = false }
	func openProfileEdit() { rootCoordinator.open(screen: .profileEdit) }
	func openMyNFTs() { rootCoordinator.open(screen: .myNfts) }
	func openLikedNFTs() { rootCoordinator.open(screen: .favorites) }
	func goBack() { rootCoordinator.goBack() }
	func openUserAgreement() {
		guard let url = URL(string: "https://yandex.ru/legal/practicum_termsofuse") else { return }
		rootCoordinator.open(screen: .web(url: url))
	}
	func openWebsite(url: URL) {
		rootCoordinator.open(screen: .web(url: url))
	}
}
