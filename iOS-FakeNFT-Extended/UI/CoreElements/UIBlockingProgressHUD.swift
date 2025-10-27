//
//  UIBlockingProgressHUD.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 18.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import UIKit
import ProgressHUD

@MainActor
enum UIBlockingProgressHUD {
	private static var window: UIWindow? {
		(UIApplication.shared.connectedScenes
			.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene)?
			.windows.first
	}

	private static var savedWindow: UIWindow?

	static func show() {
		savedWindow = window
		savedWindow?.isUserInteractionEnabled = false
		ProgressHUD.animate()
	}

	static func dismiss() {
		savedWindow?.isUserInteractionEnabled = true
		savedWindow = nil
		ProgressHUD.dismiss()
	}
}

@MainActor
enum UIProgressHUD {
	static func show() {
		ProgressHUD.animate()
	}

	static func dismiss() {
		ProgressHUD.dismiss()
	}

	static func handleLoading(_ oldValue: Bool, _ newValue: Bool) {
		if newValue {
			ProgressHUD.animate()
		} else {
			ProgressHUD.dismiss()
		}
	}
}
