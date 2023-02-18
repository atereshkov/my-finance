import Combine

import AppState
import MyFinanceDomain
import Repositories

public protocol SavingsDataServiceType {
    func getSavingsSteps(savingsId: String) async throws -> [SavingsStepDVO]
    func deleteSavingsStep(stepId: String, value: Double, savingsId: String) async throws
    func deleteSavings(savingsId: String) async throws
}

public class SavingsDataService: SavingsDataServiceType {

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

    public func getSavingsSteps(savingsId: String) async throws -> [SavingsStepDVO] {
        // TODO return error instead
        let userId = appState[\.user.id]!

        let dto = try await savingsStepRepository.getSavingsSteps(savingsId, userId: userId)
        return dto
            .compactMap { SavingsStepDVO($0) }
            .sorted(by: { $0.date > $1.date })
    }

    public func deleteSavingsStep(stepId: String, value: Double, savingsId: String) async throws {
        let userId = appState[\.user.id]!

        try await savingsStepRepository.deleteSavingsStep(id: stepId, savingsId: savingsId, userId: userId)
        try await savingsRepository.updateCurrentValue(id: savingsId, value: value, isAdd: false, userId: userId)
    }

    public func deleteSavings(savingsId: String) async throws {
        let userId = appState[\.user.id]!
        try await savingsRepository.deleteSavings(id: savingsId, userId: userId)
    }

}
