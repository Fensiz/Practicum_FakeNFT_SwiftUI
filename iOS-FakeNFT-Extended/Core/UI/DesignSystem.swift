//
//  DesignSystem.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 24.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import SwiftUI

enum DesignSystem {}

extension DesignSystem {
	enum Color {
		static let background = SwiftUI.Color.ypWhite
		static let backgroundSecondary = SwiftUI.Color.ypLightGrey
		static let textPrimary = SwiftUI.Color.ypBlack
		static let primary = SwiftUI.Color.ypBlack
		static let accentDestructive = SwiftUI.Color.ypURed
		static let accent = SwiftUI.Color.ypUGreen
		static let buttonBackground = SwiftUI.Color.ypBlack
		static let buttonText = SwiftUI.Color.ypWhite
	}
	enum Spacing {
		static let xxsmall: CGFloat = 2
		static let xsmall: CGFloat = 4
		static let xxxsmall: CGFloat = 5
		static let small: CGFloat = 8
		static let small2: CGFloat = 7
		static let medium: CGFloat = 12
		static let medium2: CGFloat = 16
		static let large: CGFloat = 20
		static let xlarge: CGFloat = 28
		static let large2: CGFloat = 40
		static let xxlarge: CGFloat = 41
	}
	enum Padding {
		static let xxsmall: CGFloat = 2
		static let xsmall2: CGFloat = 4
		static let xsmall: CGFloat = 5
		static let small2: CGFloat = 8
		static let small: CGFloat = 12
		static let medium: CGFloat = 16
		static let large: CGFloat = 20
		static let xlarge: CGFloat = 24
	}
	enum Radius {
		static let xsmall: CGFloat = 6
		static let small: CGFloat = 12
		static let medium: CGFloat = 16
		static let large: CGFloat = 20
	}
	enum Font {
		static let caption1 = SwiftUI.Font.system(size: 15, weight: .regular)
		static let caption2 = SwiftUI.Font.system(size: 13, weight: .regular)
		static let bodyBold = SwiftUI.Font.system(size: 17, weight: .bold)
		static let bodyRegular = SwiftUI.Font.system(size: 17, weight: .regular)
		static let bodySemibold = SwiftUI.Font.system(size: 17, weight: .semibold)
		static let headline1 = SwiftUI.Font.system(size: 34, weight: .bold)
		static let headline2 = SwiftUI.Font.system(size: 28, weight: .bold)
		static let headline3 = SwiftUI.Font.system(size: 22, weight: .bold)
		static let headline4 = SwiftUI.Font.system(size: 20, weight: .bold)
	}
	enum Sizes {
		static let elementSmallHeight: CGFloat = 38
		static let elementMediumHeight: CGFloat = 76
		static let elementLargeHeight: CGFloat = 80
		static let elementXSmallWidth: CGFloat = 27
		static let buttonSmallHeight: CGFloat = 44
		static let buttonLargeHeight: CGFloat = 60
		static let buttonSmallWidth: CGFloat = 127
		static let buttonMediumWidth: CGFloat = 240
		static let imageXXSmall: CGFloat = 13
		static let imageSmall3: CGFloat = 28
		static let imageXSmall: CGFloat = 36
		static let imageSmall: CGFloat = 48
		static let imageSmall2: CGFloat = 23
		static let imageMedium: CGFloat = 108
		static let imageMedium2: CGFloat = 70
	}
	enum BorderWidth {
		static let small: CGFloat = 1
	}
}
