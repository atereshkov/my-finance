import SwiftUI

import MyFinanceAssetsKit

public struct TabBarView: View {

    let providers: [TabViewProvider]

    public init(providers: [TabViewProvider]) {
        self.providers = providers

        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().backgroundColor = UIColor(.primaryBackground)
    }

    public var body: some View {
        TabView {
            ForEach(providers, id: \.tabName) { provider in
                provider.viewProvider()
                    .tabItem {
                        Image(systemName: provider.systemImageName)
                        Text(provider.tabName)
                    }
            }
        }
    }
}
