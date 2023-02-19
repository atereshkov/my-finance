import MyFinanceDomain

enum SavingsStepDetailsSheetType {
    case editSavings(_ id: String)
    case addSavingsStep(_ id: String)
    case editSavingsStep(_ step: SavingsStepDVO, _ savingsId: String)
}
