import Foundation
import Combine

import AppState
import MyFinanceDomain

public class DepositsListViewModel: ObservableObject {

    private var cancellables: Set<AnyCancellable> = []

    // MARK: Output

    @Published var deposits: [DepositDVO] = []
    @Published var routingState = DepositsListRouting()

    // MARK: - Lifecycle

    public init(appState: Store<AppState>) {
        appState.map(\.data.deposits)
            .sink { [weak self] data in
                self?.deposits = data.sorted(by: { $0.endDate > $1.endDate })
            }
            .store(in: &cancellables)
    }

    deinit {
        Swift.print("[Deinit] DepositsListViewModel")
    }

}

// MARK: - Internal

extension DepositsListViewModel {

    func addGoalAction() {
        routingState.show(sheet: .addDeposit)
    }

}
