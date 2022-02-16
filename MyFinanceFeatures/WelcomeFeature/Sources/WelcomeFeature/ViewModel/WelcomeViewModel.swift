import SwiftUI
import Combine

import AppState

public class WelcomeViewModel: ObservableObject {

    private let appState: Store<AppState>

    public init(appState: Store<AppState>) {
        self.appState = appState
    }

    // MARK: - Input

    // MARK: - Output

}

extension WelcomeViewModel {

    func signInAction() {
        appState[\.auth.isAuthorized] = true
    }

}
