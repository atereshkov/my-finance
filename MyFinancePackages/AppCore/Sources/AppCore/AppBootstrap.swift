import AppState

public class AppBootstrap {

    public init() {
        
    }

    /// Sets the initial data to the AppState object.
    /// - Parameter state: AppState object that will be updated asynchronously
    public func boot(with state: Store<AppState>) {
        state[\.auth.isAuthorized] = true
    }

}
