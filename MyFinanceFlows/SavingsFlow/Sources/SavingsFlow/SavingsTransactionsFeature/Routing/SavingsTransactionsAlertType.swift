import MyFinanceDomain

enum SavingsTransactionsAlertType {
    case confirmDeleteTransaction(_ item: SavingsTransactionDVO)
    case confirmDeleteAllTransactions(_ item: SavingsDVO)
}
