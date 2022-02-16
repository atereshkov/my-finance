import AppState

public class AppBootstrap {

    private let state: Store<AppState>

    public init(state: Store<AppState>) {
        self.state = state
    }

    public func boot() {
        state[\.auth.isAuthorized] = true
    }

}
