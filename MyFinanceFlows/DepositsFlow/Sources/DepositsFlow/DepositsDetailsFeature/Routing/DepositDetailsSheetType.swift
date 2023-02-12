import MyFinanceDomain

enum DepositDetailsSheetType {
    case editDeposit(_ id: String)
    case addDepositStep(_ id: String)
    case editDepositStep(_ step: DepositStepDVO, _ depositId: String)
}
