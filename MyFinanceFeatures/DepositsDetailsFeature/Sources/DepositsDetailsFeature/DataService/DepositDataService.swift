import Combine

import AppState
import MyFinanceDomain
import Repositories

public protocol DepositDataServiceType {
    func getDepositSteps(depositId: String) async throws -> [DepositStepDVO]
    func deleteDepositStep(stepId: String, value: Double, depositId: String) async throws
}

public class DepositDataService: DepositDataServiceType {

    private var cancellables: Set<AnyCancellable> = []

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

    public func getDepositSteps(depositId: String) async throws -> [DepositStepDVO] {
        // TODO return error instead
        let userId = appState[\.user.id]!

        let dto = try await depositStepRepository.getDepositSteps(depositId, userId: userId)
        return dto
            .compactMap { DepositStepDVO($0) }
            .sorted(by: { $0.date > $1.date })
    }

    public func deleteDepositStep(stepId: String, value: Double, depositId: String) async throws {
        let userId = appState[\.user.id]!

        try await depositStepRepository.deleteDepositStep(id: stepId, depositId: depositId, userId: userId)
        try await depositRepository.updateBalance(id: depositId, value: value, isAdd: false, userId: userId)
    }

}
