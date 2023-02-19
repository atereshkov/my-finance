import Combine

import AppState
import MyFinanceDomain
import Repositories

public protocol SavingsDataServiceType {
    func deleteSavings(savingsId: String) async throws
}

public class SavingsDataService: SavingsDataServiceType {

    private var cancellables: Set<AnyCancellable> = []

    private let appState: Store<AppState>
    private let savingsRepository: SavingsRepository

    public init(
        appState: Store<AppState>,
        savingsRepository: SavingsRepository
    ) {
        self.appState = appState
        self.savingsRepository = savingsRepository
    }

    public func deleteSavings(savingsId: String) async throws {
        let userId = appState[\.user.id]!
        try await savingsRepository.deleteSavings(id: savingsId, userId: userId)
    }

}
