import SwiftUI

public struct TabViewProvider {

    let systemImageName: String
    let tabName: String
    let viewProvider: () -> AnyView

    public init(
        systemImageName: String,
        tabName: String,
        viewProvider: @escaping () -> AnyView
    ) {
        self.systemImageName = systemImageName
        self.tabName = tabName
        self.viewProvider = viewProvider
    }
}
