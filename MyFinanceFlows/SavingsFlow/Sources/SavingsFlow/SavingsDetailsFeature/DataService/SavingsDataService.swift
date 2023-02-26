import Combine

import AppState
import MyFinanceDomain
import Repositories

public protocol SavingsDataServiceType {
    func getTransactions(savingsId: String, currencies: [String]) async throws  -> [SavingsTransactionDVO]
    func deleteSavings(savingsId: String) async throws
}

public class SavingsDataService: SavingsDataServiceType {

    private var cancellables: Set<AnyCancellable> = []

    private let appState: Store<AppState>
    private let savingsRepository: SavingsRepository
    private let transactionsRepository: SavingsTransactionsRepository

    public init(
        appState: Store<AppState>,
        savingsRepository: SavingsRepository,
        transactionsRepository: SavingsTransactionsRepository
    ) {
        self.appState = appState
        self.savingsRepository = savingsRepository
        self.transactionsRepository = transactionsRepository
    }

    public func getTransactions(savingsId: String, currencies: [String]) async throws -> [SavingsTransactionDVO] {
        let userId = appState[\.user.id]!

        var dtoArray: [SavingsTransactionDTO] = []
        for currency in currencies {
            let dto = try await transactionsRepository.getTransactions(savingsId, currency: currency, userId: userId)
            dtoArray.append(contentsOf: dto)
        }
        return dtoArray
            .compactMap { SavingsTransactionDVO($0) }
            .sorted(by: { $0.date > $1.date })
    }

    public func deleteSavings(savingsId: String) async throws {
        let userId = appState[\.user.id]!
        try await savingsRepository.deleteSavings(id: savingsId, userId: userId)
    }

}
