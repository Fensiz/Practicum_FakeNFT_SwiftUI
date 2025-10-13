//
//  StatisticView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Алина on 11.10.2025.
//
import SwiftUI

struct StatisticView: View {
    @State private var selectedSort = StatisticList.SortOption.byRating
    @State private var showSortDialog = false

    var body: some View {
        NavigationStack {
            StatisticList(sortOption: selectedSort)
                .toolbar {
                    NavigationMenuButton(icon: .sort) {
                        showSortDialog = true
                    }
                }
                .toolbar(.visible, for: .navigationBar)
                .confirmationDialog("Сортировка", isPresented: $showSortDialog, titleVisibility: .visible) {
                    Button("По имени") {
                        selectedSort = .byName
                    }

                    Button("По рейтингу") {
                        selectedSort = .byRating
                    }

                    Button("Закрыть", role: .cancel) { }
                }
        }
    }
}

#Preview("StatisticView") {
    TabView {
        Text("Каталог")
            .tabItem { Label(Tab.catalog.title, image: Tab.catalog.image) }

        Text("Корзина")
            .tabItem { Label(Tab.cart.title, image: Tab.cart.image) }

        Text("Профиль")
            .tabItem { Label(Tab.profile.title, image: Tab.profile.image) }

        StatisticView()
            .tabItem { Label(Tab.statistic.title, image: Tab.statistic.image) }
    }
    .accentColor(.ypUBlue)
}
