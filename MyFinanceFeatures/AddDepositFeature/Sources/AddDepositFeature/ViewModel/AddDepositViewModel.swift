import Foundation
import Combine

import AppState
import MyFinanceDomain

public class AddDepositViewModel: ObservableObject {

    private var cancellables: Set<AnyCancellable> = []

    private let dataService: AddDepositDataServiceType

    // MARK: Input

    @Published var bankName: String?
    @Published var name: String?
    @Published var rate: String?
    @Published var tax: String?
    @Published var startValue: String?
    @Published var isRevocable: Bool = false
    @Published var isCapitalizable: Bool = true
    @Published var customPeriodDays: String?

    @Published var currencyIndex: Int = 0
    @Published var payoutIndex: Int = 0
    @Published var startDate = Date()
    @Published var endDate = Date()
    @Published var topUpEndDate = Date()

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

    @Published var payoutOptions: [Int: PayoutOption] = [
        0: .weekly,
        1: .twiceMonth,
        2: .monthly,
        3: .eachTwoMonths,
        4: .quarterly,
        5: .custom
    ]

    @Published var dismissAction: Bool = false

    var isCustomCapitalizationPeriod: Bool {
        return payoutOptions[payoutIndex] == .custom
    }

    public init(
        appState: Store<AppState>,
        service: AddDepositDataService
    ) {
        self.dataService = service

        $name
            .sink { [weak self] in self?.title = $0 ?? "New Deposit" }
            .store(in: &cancellables)
    }

    func addDepositAction() async {
        var data: [String: Any] = [
            "bankName": bankName ?? "",
            "name": name ?? "",
            "currency": currencyOptions[currencyIndex].id,
            "payout": payoutOptions[payoutIndex]?.dtoValue() ?? "",
            "startValue": Double(startValue ?? "") ?? 0,
            "rate": Double(rate ?? "") ?? 0,
            "tax": Double(tax ?? "") ?? 0,
            "startValue": Double(startValue ?? "") ?? 0,
            "isRevocable": isRevocable,
            "isCapitalizable": isCapitalizable,
            "startDate": startDate,
            "endDate": endDate,
            "topUpEndDate": topUpEndDate
        ]
        if isCustomCapitalizationPeriod, let days = customPeriodDays {
            data["customCapitalizationPeriod"] = Int(days)
        }

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
