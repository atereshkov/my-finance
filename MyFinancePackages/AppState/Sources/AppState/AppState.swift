public struct AppState: Equatable {
    public var auth = AuthState()
    public var user = UserData()
    public var data = DataState()
    public var routing = ViewRouting()
    public var system = System()

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
        var books: [String] = []
    }
}

public extension AppState {
    struct ViewRouting: Equatable {

    }
}

public extension AppState {
    struct System: Equatable {
        var isActive: Bool = false
    }
}

public func == (lhs: AppState, rhs: AppState) -> Bool {
    return lhs.auth == rhs.auth &&
        lhs.routing == rhs.routing &&
        lhs.system == rhs.system &&
        lhs.user == rhs.user
}
