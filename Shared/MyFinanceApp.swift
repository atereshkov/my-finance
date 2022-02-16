import SwiftUI

import AppCore

@main
struct MyFinanceApp: App {

    let environment = AppEnvironment.start()

    init() {
        let bootstrap = AppBootstrap()
        bootstrap.boot(with: environment.appState)
    }

    var body: some Scene {
        WindowGroup {
            AppView(appState: environment.appState)
        }
    }

}
