import MyFinanceDomain

enum SavingsTransactionsSheetType {
    case addTransaction(_ id: String)
    case editTransaction(_ transaction: SavingsTransactionDVO, _ savingsId: String)
}
