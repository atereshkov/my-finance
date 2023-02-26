import Combine

import AppState
import MyFinanceDomain
import Repositories

public protocol SavingsTransactionsDataServiceType {
    func getTransactions(savingsId: String, currency: String) async throws -> [SavingsTransactionDVO]
    func deleteTransaction(id: String, value: Double, currency: String, isAdd: Bool, savingsId: String) async throws
}

public class SavingsTransactionsDataService: SavingsTransactionsDataServiceType {

    private var cancellables: Set<AnyCancellable> = []

    private let appState: Store<AppState>
    private let transactionsRepository: SavingsTransactionsRepository
    private let savingsRepository: SavingsRepository

    public init(
        appState: Store<AppState>,
        transactionsRepository: SavingsTransactionsRepository,
        savingsRepository: SavingsRepository
    ) {
        self.appState = appState
        self.transactionsRepository = transactionsRepository
        self.savingsRepository = savingsRepository
    }

    public func getTransactions(savingsId: String, currency: String) async throws -> [SavingsTransactionDVO] {
        // TODO return error instead
        let userId = appState[\.user.id]!

        let dto = try await transactionsRepository.getTransactions(savingsId, currency: currency, userId: userId)
        return dto
            .compactMap { SavingsTransactionDVO($0) }
            .sorted(by: { $0.date > $1.date })
    }

    public func deleteTransaction(id: String, value: Double, currency: String, isAdd: Bool, savingsId: String) async throws {
        let userId = appState[\.user.id]!

        try await transactionsRepository.deleteTransaction(id: id, savingsId: savingsId, currency: currency, userId: userId)
        try await savingsRepository.updateCurrentValue(id: savingsId, currency: currency, value: value, isAdd: !isAdd, userId: userId)
    }

}
