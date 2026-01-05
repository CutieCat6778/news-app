import Apollo
import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            NavigationStack {
                HomePage(viewModel: HomePageModel())
            }
            .tabItem {
                Label("home_tab", systemImage: "house")
            }

            SearchPage()
                .tabItem {
                    Label("search_tab", systemImage: "magnifyingglass")
                }

            ProfilePage()
                .tabItem {
                    Label("profile_tab", systemImage: "person.crop.circle")
                }
        }
    }
}
