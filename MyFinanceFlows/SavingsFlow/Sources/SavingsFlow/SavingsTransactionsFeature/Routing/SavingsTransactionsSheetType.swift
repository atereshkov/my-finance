import MyFinanceDomain

enum SavingsTransactionsSheetType {
    case addTransaction(_ id: String)
    case editTransaction(_ transaction: SavingsStepDVO, _ savingsId: String)
}
