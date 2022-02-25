import Foundation
import Combine

import AppState
import Repositories
import MyFinanceDomain

public protocol AddDepositDataServiceType {
    func addDeposit(data: [String: Any]) async throws
}

public class AddDepositDataService: AddDepositDataServiceType {

    private let appState: Store<AppState>
    private let depositRepository: DepositRepository

    public init(appState: Store<AppState>, depositRepository: DepositRepository) {
        self.appState = appState
        self.depositRepository = depositRepository
    }

    public func addDeposit(data: [String: Any]) async throws {
        // TODO return error instead
        let userId = appState[\.user.id]!

        let deposit = AddDepositDTO(data)
        try await depositRepository.addDeposit(deposit, userId: userId)
    }

}
