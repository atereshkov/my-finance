import Foundation
import Combine

import AppState
import Repositories
import MyFinanceDomain

public protocol AddSavingsTransactionDataServiceType {
    func addTransaction(savingsId: String, data: [String: Any]) async throws
}

public class AddSavingsTransactionDataService: AddSavingsTransactionDataServiceType {

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

    public func addTransaction(savingsId: String, data: [String: Any]) async throws {
        // TODO throw error instead
        let userId = appState[\.user.id]!

        let item = AddSavingsTransactionDTO(data)

        try await transactionsRepository.addTransaction(item, savingsId: savingsId, userId: userId)
        try await savingsRepository.updateCurrentValue(id: savingsId, currency: item.currency, value: item.value, isAdd: item.isAdd, userId: userId)
    }

}
