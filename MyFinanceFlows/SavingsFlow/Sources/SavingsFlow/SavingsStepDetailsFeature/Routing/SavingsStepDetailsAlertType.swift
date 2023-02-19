import MyFinanceDomain

enum SavingsStepDetailsAlertType {
    case confirmDeleteStep(_ item: SavingsStepDVO)
    case confirmDeleteSavings(_ item: SavingsDVO)
}
