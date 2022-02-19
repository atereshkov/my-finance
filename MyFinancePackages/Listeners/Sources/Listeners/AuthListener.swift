import AppState

import FirebaseAuth

public protocol AuthListenerType: Listener {

}

public class AuthListener: AuthListenerType {

    private var observer: AuthStateDidChangeListenerHandle?

    private let appState: Store<AppState>

    public init(appState: Store<AppState>) {
        self.appState = appState
    }

    public func start() {
        listenAuthChanges()
    }

    public func stop() {
        guard observer != nil else { return }

        Auth.auth().removeStateDidChangeListener(observer!)
        observer = nil
    }

}

private extension AuthListener {

    private func listenAuthChanges() {
        observer = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            self?.appState[\.auth.isAuthorized] = true
            // TODO
//            self?.appState[\.auth.isAuthorized] = user != nil
//            self?.appState[\.user.id] = user?.uid
        }
    }

}
