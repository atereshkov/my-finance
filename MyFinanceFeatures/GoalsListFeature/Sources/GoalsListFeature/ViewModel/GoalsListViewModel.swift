import Foundation

public class GoalsListViewModel: ObservableObject {

    // MARK: Output

    @Published var goals: [GoalsViewItem] = [
        GoalsViewItem(id: "1", name: "Goals 1"),
        GoalsViewItem(id: "2", name: "Goals 2"),
        GoalsViewItem(id: "3", name: "Goals 3")
    ]

    @Published var routingState = GoalsListRouting()

    public init() {
//        cancelBag.collect {
//            $routingState
//                .sink { session.appState[\.routing.home] = $0 }
//
//            session.appState.map(\.data.portfolios)
//                .removeDuplicates()
//                .assign(to: \.portfolios, on: self)
//        }
    }

    func addGoalAction() {
        routingState.show(.addGoal)
    }

}
