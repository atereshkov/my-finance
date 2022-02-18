import Foundation

public class GoalDetailsViewModel: ObservableObject {

    // MARK: Output

    @Published var id: String
    @Published var routingState = GoalDetailsRouting()

    public init(id: String) {
        self.id = id
    }

    func editGoalAction() {
        routingState.show(.editGoal)
    }

    func addStepGoalAction() {
        routingState.show(.addGoalStep)
    }

}
