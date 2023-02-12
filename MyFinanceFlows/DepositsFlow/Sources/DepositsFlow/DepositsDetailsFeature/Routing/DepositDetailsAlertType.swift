import MyFinanceDomain

enum DepositDetailsAlertType {
    case confirmDeleteStep(_ item: DepositStepDVO)
    case confirmDeleteDeposit(_ item: DepositDVO)
}
