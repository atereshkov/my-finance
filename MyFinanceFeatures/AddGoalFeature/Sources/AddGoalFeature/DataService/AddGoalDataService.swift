import Combine

import AppState

public protocol AddGoalDataServiceType {
    func addGoal() -> Future<Void, Error>
}

public class AddGoalDataService: AddGoalDataServiceType {

    private let appState: Store<AppState>

    public init(appState: Store<AppState>) {
        self.appState = appState
    }

    public func addGoal() -> Future<Void, Error> {
        Future { promise in
            promise(.success(()))
        }
    }

}
