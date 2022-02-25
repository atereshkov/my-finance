import Foundation
import Combine

import AppState

public class AddDepositViewModel: ObservableObject {

    private var cancellables: Set<AnyCancellable> = []

    private let dataService: AddDepositDataServiceType

    // MARK: Input

    @Published var name: String?
    @Published var goal: String?
    @Published var start: String?
    @Published var current: String?

    @Published var currencyIndex: Int = 0
    @Published var startDate = Date()
    @Published var endDate = Date()

    // MARK: Output

    @Published var routingState = AddDepositRouting()
    @Published var state: AddDepositViewState = .start

    @Published var title: String?

    @Published var currencyOptions = [
        CurrencyViewItem(id: "USD", name: "USD"),
        CurrencyViewItem(id: "EUR", name: "EUR"),
        CurrencyViewItem(id: "RUB", name: "RUB"),
        CurrencyViewItem(id: "BYN", name: "BYN")
    ]

    @Published var dismissAction: Bool = false

    public init(
        appState: Store<AppState>,
        service: AddDepositDataService
    ) {
        self.dataService = service

        $name
            .sink { [weak self] in self?.title = $0 ?? "New Deposit" }
            .store(in: &cancellables)
    }

    func addGoalAction() async {
        let data: [String: Any] = [
            "name": name ?? "",
            "currency": currencyOptions[currencyIndex].id,
            "goalValue": Double(goal ?? "") ?? 0,
            "startValue": Double(start ?? "") ?? 0,
            "currentValue": Double(current ?? "") ?? 0,
            "startDate": startDate,
            "endDate": endDate
        ]

        do {
            try await dataService.addDeposit(data: data)
        } catch let error {
            Swift.print(error)
        }
    }

    func onAppear() {

    }

    func onDisappear() {
        cancellables.removeAll()
        state = .dismiss
    }

    deinit {
        Swift.print("123123 deinit")
    }

}
