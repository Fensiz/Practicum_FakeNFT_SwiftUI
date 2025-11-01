//
//  StatisticView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Алина on 11.10.2025.
//
import SwiftUI

@MainActor
struct StatisticView: View {
    @AppStorage(AppStorageKeys.statisticSortOption)
    private var sortRaw = StatisticList.SortOption.byRating.rawValue

    private var selectedSort: StatisticList.SortOption {
        StatisticList.SortOption(rawValue: sortRaw) ?? .byRating
    }

    @State private var showSortDialog = false
    @State private var viewModel = StatisticViewModel(
        usersService: UsersServiceImpl(networkClient: DefaultNetworkClient())
    )
    @State private var isNavigating = false

    @Environment(StatisticCoordinator.self) private var coordinator

    var body: some View { NavigationStack(path: coordinator.navigationPathBinding) {
        StatisticList(
            users: viewModel.sortedUsers,
            sortOption: viewModel.sortOption,
            onUserTap: { user in
                coordinator.open(screen: .userCard(user: user))
            },
            canLoadMore: viewModel.canLoadMore,
            onLoadNextPage: {
                Task {
                    await viewModel.loadNextPage()
                }
            }
        )
        .toolbarPreference(imageName: .sort) { showSortDialog = true }
        .toolbar(.visible, for: .navigationBar)
        .confirmationDialog("Сортировка", isPresented: $showSortDialog, titleVisibility: .visible) {
            Button("По имени") { sortRaw = StatisticList.SortOption.byName.rawValue }
            Button("По рейтингу") { sortRaw = StatisticList.SortOption.byRating.rawValue }
            Button("Закрыть", role: .cancel) { }
        }
        .navigationDestination(for: Screen.self) { screen in
            switch screen {
                case .userCard(let user):
                    UserCard(user: user)
                        .environment(coordinator)
                case .web(let url):
                    WebView(url: url, isAppearenceEnabled: false)
                case .userCollection(let ids):
                    UserCollectionView(nftIDs: ids)
                        .environment(coordinator)
                default:
                    EmptyView()
            }
        }
    }
    .background(
        Color.ypWhite
            .ignoresSafeArea()
    )
    .task {
        if viewModel.users.isEmpty {
            await viewModel.makeLoad()
        }
    }
    .onAppear { viewModel.makeSetSort(selectedSort) }
    .onChange(of: sortRaw) { _, _ in
        viewModel.makeSetSort(selectedSort)
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
            .environment(StatisticCoordinator.shared)
            .tabItem { Label(Tab.statistic.title, image: Tab.statistic.image) }
    }
    .accentColor(.ypUBlue)
}
