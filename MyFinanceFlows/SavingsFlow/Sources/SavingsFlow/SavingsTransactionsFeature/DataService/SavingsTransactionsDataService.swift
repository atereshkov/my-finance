import Combine

import AppState
import MyFinanceDomain
import Repositories

public protocol SavingsTransactionsDataServiceType {
    func getTransactions(savingsId: String) async throws -> [SavingsStepDVO]
    func deleteTransaction(id: String, value: Double, savingsId: String) async throws
}

public class SavingsTransactionsDataService: SavingsTransactionsDataServiceType {

    private var cancellables: Set<AnyCancellable> = []

    private let appState: Store<AppState>
    private let savingsStepRepository: SavingsStepRepository
    private let savingsRepository: SavingsRepository

    public init(
        appState: Store<AppState>,
        savingsStepRepository: SavingsStepRepository,
        savingsRepository: SavingsRepository
    ) {
        self.appState = appState
        self.savingsStepRepository = savingsStepRepository
        self.savingsRepository = savingsRepository
    }

    public func getTransactions(savingsId: String) async throws -> [SavingsStepDVO] {
        // TODO return error instead
        let userId = appState[\.user.id]!

        let dto = try await savingsStepRepository.getSavingsSteps(savingsId, userId: userId)
        return dto
            .compactMap { SavingsStepDVO($0) }
            .sorted(by: { $0.date > $1.date })
    }

    public func deleteTransaction(id: String, value: Double, savingsId: String) async throws {
        let userId = appState[\.user.id]!

//        try await savingsStepRepository.deleteSavingsStep(id: stepId, savingsId: savingsId, userId: userId)
//        try await savingsRepository.updateCurrentValue(id: savingsId, value: value, isAdd: false, userId: userId)
    }

}
