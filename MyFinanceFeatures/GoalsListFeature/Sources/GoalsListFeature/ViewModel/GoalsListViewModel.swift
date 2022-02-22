import Foundation
import Combine

import AppState
import MyFinanceDomain

public class GoalsListViewModel: ObservableObject {

//    private let appState: Store<AppState>

    private var cancellables: Set<AnyCancellable> = []

    // MARK: Output

    @Published var goals: [GoalDVO] = []
    @Published var routingState = GoalsListRouting()

    public init(appState: Store<AppState>) {
        appState.map(\.data.goals)
            .sink { [weak self] data in
                self?.goals = data
            }
            .store(in: &cancellables)
    }

    func onAppear() {

    }

    func onDisappear() {
        Swift.print("onDisappear")
    }

    func addGoalAction() {
        routingState.show(.addGoal)
    }

}
