//
//  DeleteConfirmationView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 09.10.2025.
//

import SwiftUI

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
			VStack(spacing: 20) {
				VStack(spacing: 12) {
					item.image
						.resizable()
						.frame(width: 108, height: 108)
						.clipShape(RoundedRectangle(cornerRadius: 12))
					Text("Вы уверены, что хотите\nудалить объект из корзины?")
						.multilineTextAlignment(.center)
						.font(.system(size: 13, weight: .regular))
				}
				HStack(spacing: 8) {
					Button {
						deleteAction()
					} label: {
						Text("Удалить")
							.font(.system(size: 17))
							.frame(maxWidth: .infinity, maxHeight: .infinity)
							.background(.ypBlack)
							.clipShape(RoundedRectangle(cornerRadius: 12))
					}
					.frame(width: 127, height: 44)
					.foregroundStyle(.ypURed)

					Button {
						cancelAction()
					} label: {
						Text("Вернуться")
							.font(.system(size: 17))
							.frame(maxWidth: .infinity, maxHeight: .infinity)
							.background(.ypBlack)
							.clipShape(RoundedRectangle(cornerRadius: 12))
					}
					.frame(width: 127, height: 44)
					.foregroundStyle(.ypWhite)
				}
			}
		}
	}
}
