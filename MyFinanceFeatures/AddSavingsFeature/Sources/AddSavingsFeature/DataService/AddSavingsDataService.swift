import Foundation
import Combine

import AppState
import Repositories
import MyFinanceDomain

public protocol AddSavingsDataServiceType {
    func addSavings(data: [String: Any]) async throws
}

public class AddSavingsDataService: AddSavingsDataServiceType {

    private let appState: Store<AppState>
    private let savingsRepository: SavingsRepository

    public init(appState: Store<AppState>, savingsRepository: SavingsRepository) {
        self.appState = appState
        self.savingsRepository = savingsRepository
    }

    public func addSavings(data: [String: Any]) async throws {
        // TODO return error instead
        let userId = appState[\.user.id]!

        let savings = AddSavingsDTO(data)
        try await savingsRepository.addSavings(savings, userId: userId)
    }

}
