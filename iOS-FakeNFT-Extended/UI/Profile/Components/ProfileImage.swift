//
//  ProfileImage.swift
//  iOS-FakeNFT-Extended
//
//  Created by Герман on 11.10.2025.
//

import SwiftUI

struct ProfileImage: View {
    @Environment(\.colorScheme) private var coloScheme
    var imageUrl: URL?
    var canEdit: Bool
    let onTap: () -> Void
    init(
        imageUrl: URL? = nil,
        canEdit: Bool = false,
        onTap: @escaping () -> Void = {}
    ) {
        self.imageUrl = imageUrl
        self.canEdit = canEdit
        self.onTap = onTap
    }
    var body: some View {
        Group {
            if let imageUrl {
                AsyncImage(url: imageUrl) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Circle()
                        .foregroundColor(coloScheme == .dark ? .ypUBlack : .ypUWhite)
                        .overlay {
                            ProgressView()
                        }
                        .frame(width: 70, height: 70)
                        .clipShape(Circle())
                }
            } else {
                Image("emtpy_avatar")
            }
        }
        .frame(width: 70, height: 70)
        .clipShape(Circle())
        .overlay {
            Circle()
                .frame(width: 24)
                .foregroundColor(.ypLightGrey)
                .overlay {
                    Image(.camera)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .opacity(canEdit ? 1 : 0)
                .onTapGesture {
                    if canEdit {
                        onTap()
                    }
                }
        }
    }
}

#Preview {
    LightDarkPreviewWrapper {
        ProfileImage(
            imageUrl: URL(string: "https://i.ibb.co/fVLFtWrM/c1f8f42c5f5bd684e27d93131dc6ffd4696cdfd3.jpg") ?? nil,
            canEdit: true
        ) {
            print("test")
        }
        ProfileImage(
            imageUrl: nil,
            canEdit: true
        ) {
            print("test")
        }
        ProfileImage(
            imageUrl: nil,
            canEdit: false
        ) {
            print("test")
        }
    }
}
