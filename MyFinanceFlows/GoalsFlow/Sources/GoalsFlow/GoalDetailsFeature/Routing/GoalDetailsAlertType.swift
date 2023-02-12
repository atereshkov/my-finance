import MyFinanceDomain

enum GoalDetailsAlertType {
    case confirmDeleteStep(_ item: GoalStepDVO)
    case confirmDeleteGoal(_ item: GoalDVO)
}
