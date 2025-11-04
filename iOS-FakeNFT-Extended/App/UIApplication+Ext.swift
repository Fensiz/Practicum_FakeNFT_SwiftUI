//
//  UIApplication+Ext.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 25.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import UIKit

extension UIApplication {
	static var isRunningTests: Bool {
		ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
	}
}
