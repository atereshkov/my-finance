import Foundation
import Combine

import AppState
import MyFinanceDomain

public class DepositsListViewModel: ObservableObject {

    private var cancellables: Set<AnyCancellable> = []

    // MARK: Output

    @Published var deposits: [DepositDVO] = []
    @Published var routingState = DepositsListRouting()

    public init(appState: Store<AppState>) {
        appState.map(\.data.deposits)
            .sink { [weak self] data in
                self?.deposits = data.sorted(by: { $0.endDate > $1.endDate })
            }
            .store(in: &cancellables)
    }

    func addGoalAction() {
        routingState.show(sheet: .addDeposit)
    }

}
