import MyFinanceDomain

enum SavingsTransactionsAlertType {
    case confirmDeleteTransaction(_ item: SavingsStepDVO)
    case confirmDeleteAllTransactions(_ item: SavingsDVO)
}
