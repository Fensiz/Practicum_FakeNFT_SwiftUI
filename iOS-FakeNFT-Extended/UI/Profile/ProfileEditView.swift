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
    @State private var siteUrlString: String = "https://hello.com"
    @State private var showContextMednu: Bool = false
    @State private var showSiteEditAlert: Bool = false
    @State private var avatarUrlString: String = "https://i.ibb.co/fVLFtWrM/c1f8f42c5f5bd684e27d93131dc6ffd4696cdfd3.jpg"
    @State private var newAvatarUrlString: String = ""
    @State private var isSaveInProgress: Bool = false
    
    var body: some View {
        VStack(spacing: 24) {
            ProfileImage(imageUrl: URL(string: avatarUrlString) ?? nil, canEdit: true) {
                showContextMednu = true
            }
            .actionSheet(isPresented: $showContextMednu) {
                ActionSheet(
                    title: Text("Фото профиля"),
                    buttons: [
                        .default(Text("Изменить фото")) {
                            showSiteEditAlert = true
                        },
                        .destructive(Text("Удалить фото")) {
                            avatarUrlString = ""
                        },
                        .cancel(Text("Отмена"))
                    ]
                )
            }
            .alert("Ссылка на фото", isPresented: $showSiteEditAlert) {
                TextField(avatarUrlString, text: $newAvatarUrlString)
                    .keyboardType(.URL)
                Button("Отмена") {
                    showSiteEditAlert = false
                    newAvatarUrlString = ""
                }
                Button("Сохранить") {
                    avatarUrlString = newAvatarUrlString
                }
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
                TextField("", text: $siteUrlString)
                    .applyTextInputStyle()
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
        .overlay {
            ZStack {
                Color.ypLightGrey.cornerRadius(8)
                    .frame(width: 82, height: 82)
                    .colorScheme(.light)
                ProgressView()
                    .scaleEffect(1.3)
                    .colorScheme(.light)
            }
            .opacity(isSaveInProgress ? 1 : 0)
        }
        .padding(.horizontal)
        .background(Color.ypWhite)
    }
}

#Preview {
    NavigationView {
        ProfileEditView()
    }
}
