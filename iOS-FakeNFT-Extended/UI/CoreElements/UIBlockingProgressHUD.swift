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
final class UIBlockingProgressHUD {
	private init() {}
	private static var window: UIWindow? {
		(UIApplication.shared.connectedScenes
			.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene)?
			.windows.first
	}

	static func show() {
//		window?.isUserInteractionEnabled = false
		ProgressHUD.animate()
	}

	static func dismiss() {
//		window?.isUserInteractionEnabled = true
		ProgressHUD.dismiss()
	}
}
