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
	func openLikedNFTs(ids: [String], unlikeAction: @escaping (String) async -> Void)
	func openProfileEditScreen(
		for profile: ShortProfileModel,
		saveAction: @escaping (ShortProfileModel) async -> Void
	)
	func openWebsite(url: URL)
	// MARK: - Covers
	func openUserAgreement()
	func showUrlEditAlert(for url: Binding<String>, title: String)
	// MARK: - Состояние UI
	func showSaveButton()
	func hideSaveButton()
}

final class ProfileCoordinatorImpl: ProfileCoordinator {
	func openProfileEditScreen(
		for profile: ShortProfileModel,
		saveAction: @escaping (ShortProfileModel) async -> Void
	) {
		rootCoordinator.open(
			screen: .profileEdit(
				profile,
				saveAction: saveAction,
				closeAction: goBack
			)
		)
	}
	private let rootCoordinator: any RootCoordinator
	private var _shouldShowSaveButton = false
	var shouldShowSaveButton: Bool { _shouldShowSaveButton }
	init(rootCoordinator: any RootCoordinator) {
		self.rootCoordinator = rootCoordinator
	}
	func showSaveButton() { _shouldShowSaveButton = true }
	func hideSaveButton() { _shouldShowSaveButton = false }
	func openMyNFTs() { rootCoordinator.open(screen: .myNfts) }
	func openLikedNFTs(
		ids: [String],
		unlikeAction: @escaping (String) async -> Void) { rootCoordinator.open(
			screen: .favorites(ids: ids, unlikeAction: unlikeAction)
		) }
	func goBack() { rootCoordinator.goBack() }
	func openUserAgreement() {
		guard let url = URL(string: "https://yandex.ru/legal/practicum_termsofuse") else { return }
		rootCoordinator.open(screen: .web(url: url))
	}
	func openWebsite(url: URL) {
		rootCoordinator.open(screen: .web(url: url))
	}
	func showUrlEditAlert(for url: Binding<String>, title: String) {
		rootCoordinator.show(cover: .urlEditAlert(url: url, title: title))
	}
}
