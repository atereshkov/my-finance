import MyFinanceDomain

enum SavingsDetailsAlertType {
    case confirmDeleteStep(_ item: SavingsStepDVO)
    case confirmDeleteSavings(_ item: SavingsDVO)
}
