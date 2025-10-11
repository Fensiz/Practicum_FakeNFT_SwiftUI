//
//  ProfileEditView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Герман on 11.10.2025.
//

import SwiftUI

struct ProfileEditView: View {
    @State private var name = "Joaquin Phoenix"
    @State private var description = "Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям."
    @State private var site = "https://hello.com"

    var body: some View {
        VStack(spacing: 24) {
            ProfileImage(image: Image(.mockProfile), canEdit: true) {
                // TODO: Edit Image action
                print("Edit Image")
            }
            VStack(alignment: .leading, spacing: 8) {
                Text("Имя")
                    .font(Font(UIFont.headline3))
                TextField("Joaquin Phoenix", text: $name)
                    .applyTextInputStyle()
            }
            VStack(alignment: .leading, spacing: 8) {
                Text("Описание")
                    .font(Font(UIFont.headline3))
                TextEditor(text: $description)
                    .applyTextInputStyle()
                    .scrollContentBackground(.hidden)
            }
            .frame(maxHeight: 155) /// Не знаю как тут сделать hagContent–поведение, помогите
            VStack(alignment: .leading, spacing: 8) {
                Text("Сайт")
                    .font(Font(UIFont.headline3))
                TextField("", text: $site)
                    .applyTextInputStyle()
                    .disabled(true)
                    .onTapGesture {
                        // TODO: Alert site edit action
                        print("Edit Site")
                    }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .overlay(alignment: .bottom, content: {
            // TODO: Show it when data was changed
            Button(action: {
                // TODO: Save action
                print("Saved")
            }) {
                Text("Сохранить")
                    .frame(maxWidth: .infinity)
                    .font(Font(UIFont.bodyBold))
                    .foregroundColor(.ypWhite)
                    .padding(.vertical, 19)
                    .padding(.horizontal, 8)
                    .background(Color.ypBlack.cornerRadius(16))
            }
            .padding()
            
        })
        .padding(.horizontal)
        .background(Color.ypWhite)
    }
}

#Preview {
    NavigationView {
        ProfileEditView()
    }
}
