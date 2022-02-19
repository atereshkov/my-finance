public struct AppState: Equatable {
    public var auth = AuthState()
    public var user = UserData()
    public var data = DataState()
    public var routing = ViewRouting()

    public init() {

    }
}

public extension AppState {
    struct AuthState: Equatable {
        public var isAuthorized: Bool = false
    }
}

public extension AppState {
    struct UserData: Equatable {
        var id: String?
    }
}

public extension AppState {
    struct DataState: Equatable {
        var goals: [String] = []
    }
}

public extension AppState {
    struct ViewRouting: Equatable {
        
    }
}

public func == (lhs: AppState, rhs: AppState) -> Bool {
    return lhs.auth == rhs.auth &&
        lhs.routing == rhs.routing &&
        lhs.user == rhs.user
}
