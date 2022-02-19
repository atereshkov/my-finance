import AppState

public struct AppEnvironment {
    public let appState: Store<AppState>
}

public extension AppEnvironment {

    static func start() -> AppEnvironment {
        let appState = Store<AppState>(AppState())
        return AppEnvironment(appState: appState)
    }

}
