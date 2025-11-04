//
//  DeleteConfirmationView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 09.10.2025.
//

import SwiftUI
import Kingfisher

struct DeleteConfirmationView: View {
	let item: CartItem
	let deleteAction: () -> Void
	let cancelAction: () -> Void

	var body: some View {
		ZStack {
			Color.clear
				.ignoresSafeArea()
				.background(.ultraThinMaterial)
				.edgesIgnoringSafeArea(.all)
			VStack(spacing: DesignSystem.Spacing.large) {
				VStack(spacing: DesignSystem.Spacing.medium) {
					KFImage(item.image)
						.resizable()
						.scaledToFit()
						.frame(width: DesignSystem.Sizes.imageMedium, height: DesignSystem.Sizes.imageMedium)
						.clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.small))
					Text("Вы уверены, что хотите\nудалить объект из корзины?")
						.multilineTextAlignment(.center)
						.font(DesignSystem.Font.caption2)
				}
				HStack(spacing: DesignSystem.Spacing.small) {
					Group {
						Button("Удалить", action: deleteAction)
							.buttonStyle(
								PrimaryButtonStyle(
									cornerRadius: DesignSystem.Radius.small,
									foregroundColor: DesignSystem.Color.accentDestructive,
									font: DesignSystem.Font.bodyRegular
								)
							)
						Button("Вернуться", action: cancelAction)
							.buttonStyle(
								PrimaryButtonStyle(
									cornerRadius: DesignSystem.Radius.small,
									font: DesignSystem.Font.bodyRegular
								)
							)
					}
					.frame(width: DesignSystem.Sizes.buttonSmallWidth)
				}
				.frame(height: DesignSystem.Sizes.buttonSmallHeight)
			}
		}
	}
}

#Preview {
	DeleteConfirmationView(item: .mock1, deleteAction: {}, cancelAction: {})
}
