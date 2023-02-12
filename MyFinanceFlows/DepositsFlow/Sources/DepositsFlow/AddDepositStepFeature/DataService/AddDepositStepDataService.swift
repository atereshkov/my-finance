import Foundation
import Combine

import AppState
import Repositories
import MyFinanceDomain

public protocol AddDepositStepDataServiceType {
    func addDepositStep(depositId: String, data: [String: Any]) async throws
}

public class AddDepositStepDataService: AddDepositStepDataServiceType {

    private let appState: Store<AppState>
    private let depositStepRepository: DepositStepRepository
    private let depositRepository: DepositRepository

    public init(
        appState: Store<AppState>,
        depositStepRepository: DepositStepRepository,
        depositRepository: DepositRepository
    ) {
        self.appState = appState
        self.depositStepRepository = depositStepRepository
        self.depositRepository = depositRepository
    }

    public func addDepositStep(depositId: String, data: [String: Any]) async throws {
        // TODO throw error instead
        let userId = appState[\.user.id]!

        let step = AddDepositStepDTO(data)

        try await depositStepRepository.addDepositStep(step, depositId: depositId, userId: userId)
        try await depositRepository.updateBalance(id: depositId, value: step.value, isAdd: step.isAdd, userId: userId)
    }

}
