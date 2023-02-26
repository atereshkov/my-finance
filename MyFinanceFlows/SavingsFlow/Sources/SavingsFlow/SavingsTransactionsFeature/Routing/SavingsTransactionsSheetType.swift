import MyFinanceDomain

enum SavingsTransactionsSheetType {
    case addTransaction(_ id: String, _ currency: String?)
    case editTransaction(_ transaction: SavingsTransactionDVO, _ savingsId: String)
}
