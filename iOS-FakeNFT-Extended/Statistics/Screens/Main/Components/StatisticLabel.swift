//
//  StatisticLabel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Алина on 11.10.2025.
//
import SwiftUI

struct StatisticLabel: View {
	
	private enum Constants {
		static let minScaleFactor: CGFloat = 0.5
		static let lineLimit: Int = 1
	}
	
	let text: String
	let font: Font
	var foregroundColor: Color = DesignSystem.Color.textPrimary
	var maxWidth: CGFloat?
	var maxHeight: CGFloat?
	
	var body: some View {
		Text(text)
			.font(font)
			.foregroundColor(foregroundColor)
			.frame(maxWidth: maxWidth, maxHeight: maxHeight)
			.lineLimit(Constants.lineLimit)
			.minimumScaleFactor(Constants.minScaleFactor)
	}
}
