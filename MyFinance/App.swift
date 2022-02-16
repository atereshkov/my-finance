import SwiftUI

import AppCore

@main
struct MyFinanceApp: App {

    let environment = AppEnvironment.start()

    init() {
        let bootstrap = AppBootstrap(state: environment.appState)
        bootstrap.boot()
    }

    var body: some Scene {
        WindowGroup {
            AppView(appState: environment.appState)
        }
    }

}
