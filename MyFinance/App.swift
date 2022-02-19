import SwiftUI

import AppCore

@main
struct MyFinanceApp: App {

    let environment = AppEnvironment.start()
    let bootstrap: AppBootstrap

    init() {
        bootstrap = AppBootstrap(appState: environment.appState)
        bootstrap.boot()
    }

    var body: some Scene {
        WindowGroup {
            AppView(appState: environment.appState)
        }
    }

}
