import AppState

import FirebaseFramework
import Listeners

public class AppBootstrap {

    private let appState: Store<AppState>
    private var listeners: [Listener] = []

    public init(appState: Store<AppState>) {
        self.appState = appState
    }

    public func boot() {
        bootFirebase()
        bootListeners()
    }

}

private extension AppBootstrap {

    func bootFirebase() {
        let firebase = FirebaseFramework()
        firebase.boot()
    }

    func bootListeners() {
        listeners = [
            AuthListener(appState: appState),
            GoalsListener(appState: appState),
            DepositsListener(appState: appState),
            SavingsListener(appState: appState)
        ]
        for listener in listeners {
            listener.start()
        }
    }

}
