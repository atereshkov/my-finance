import AppState

import Firebase

public struct AppEnvironment {
    public let appState: Store<AppState>
}

public extension AppEnvironment {

    static func start() -> AppEnvironment {
        FirebaseApp.configure()
        let appState = Store<AppState>(AppState())
        return AppEnvironment(appState: appState)
    }

}
