import SwiftUI

public struct RootView<Welcome: View, TabBar: View>: View {

    @ObservedObject var viewModel: RootViewModel

    private var welcomeViewProvider: () -> Welcome
    private var tabBarViewProvider: () -> TabBar

    public init(
        viewModel: RootViewModel,
        welcomeViewProvider: @escaping () -> Welcome,
        tabBarViewProvider: @escaping () -> TabBar
    ) {
        self.viewModel = viewModel
        self.welcomeViewProvider = welcomeViewProvider
        self.tabBarViewProvider = tabBarViewProvider
    }

    public var body: some View {
        if viewModel.isAuthorized {
            AnyView(tabBarViewProvider())
        } else {
            AnyView(welcomeViewProvider())
        }
    }

}
