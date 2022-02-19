import Foundation
import Combine

import AppState

public class GoalsListViewModel: ObservableObject {

//    private let appState: Store<AppState>

    private var cancellables: Set<AnyCancellable> = []

    // MARK: Output

    @Published var goals: [GoalsViewItem] = []
    @Published var routingState = GoalsListRouting()

    public init(appState: Store<AppState>) {
//        self.appState = appState

        appState.map(\.data.goals)
            .sink { [weak self] data in
                self?.goals = data.map { GoalsViewItem($0) }
            }
            .store(in: &cancellables)
    }

    func onAppear() {
//        appState.map(\.data.goals)
//            .sink { [weak self] data in
//                let s = self?.appState[\.data.goals]
//                self?.goals = data.map { GoalsViewItem(id: $0, name: $0) }
//            }
//            .store(in: &cancellables)
    }

    func addGoalAction() {
        routingState.show(.addGoal)
    }

}
