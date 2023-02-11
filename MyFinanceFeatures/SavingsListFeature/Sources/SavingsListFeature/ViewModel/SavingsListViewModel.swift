import Foundation
import Combine

import AppState
import MyFinanceDomain

public class SavingsListViewModel: ObservableObject {

    private var cancellables: Set<AnyCancellable> = []

    // MARK: Output

    @Published var savings: [SavingsDVO] = []
    @Published var routingState = SavingsListRouting()

    // MARK: - Lifecycle

    public init(appState: Store<AppState>) {
        appState.map(\.data.savings)
            .sink { [weak self] data in
                self?.savings = data
            }
            .store(in: &cancellables)
    }

    deinit {
        Swift.print("[Deinit] SavingsListViewModel")
    }

}

// MARK: - Internal

extension SavingsListViewModel {

    func addSavingsAction() {
        routingState.show(sheet: .addSavings)
    }

}
