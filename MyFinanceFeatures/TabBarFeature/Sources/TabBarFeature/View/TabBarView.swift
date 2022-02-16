import SwiftUI

public struct TabBarView: View {

    let providers: [TabViewProvider]

    public init(providers: [TabViewProvider]) {
        self.providers = providers
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
