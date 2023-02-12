import MyFinanceDomain

enum GoalDetailsSheetType {
    case editGoal(_ id: String)
    case addGoalStep(_ id: String)
    case editGoalStep(_ step: GoalStepDVO, _ goalId: String)
}
