//
//  ShimmerModifier.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 31.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import SwiftUI

struct ShimmerModifier: ViewModifier {
	@State private var phase: CGFloat = -1.0
	let speed: Double = 2
	let angle: Angle = .degrees(0)

	func body(content: Content) -> some View {
		content
			.overlay {
				GeometryReader { geo in
					let stripeWidth = max(geo.size.width, 100) * 1.6
					let gradient = LinearGradient(
						gradient: Gradient(stops: [
							.init(color: Color.ypLightGrey.opacity(0.0), location: 0.0),
							.init(color: Color.white.opacity(0.6), location: 0.5),
							.init(color: Color.ypLightGrey.opacity(0.0), location: 1.0)
						]),
						startPoint: .leading,
						endPoint: .trailing
					)

					Rectangle()
						.fill(gradient)
						.frame(width: stripeWidth, height: geo.size.height * 1.5)
						.rotationEffect(angle)
						.offset(x: phase * (geo.size.width + stripeWidth))
						.mask(content)
				}
			}
			.onAppear {
				withAnimation(.linear(duration: speed).repeatForever(autoreverses: false)) {
					phase = 1
				}
			}
	}
}

extension View {
	@ViewBuilder
	func shimmer(active: Bool = true) -> some View {
		if active {
			self.modifier(ShimmerModifier())
		} else {
			self
		}
	}
}
