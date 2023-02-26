import Foundation
import Combine

import AppState

public class AddSavingsTransactionViewModel: ObservableObject {

    private var cancellables: Set<AnyCancellable> = []

    private let savingsId: String
    private let dataService: AddSavingsTransactionDataServiceType

    // MARK: Input

    @Published var value: String?
    @Published var date = Date()
    @Published var isAdd = true

    @Published var currency: SavingsMeasureViewItem?
    @Published var currencyCanBeChanged: Bool = true

    // MARK: Output

    @Published var routingState = AddSavingsTransactionRouting()
    @Published var state: AddSavingsTransactionViewState = .start

    @Published var title: String = "New Transaction"

    @Published var currencies = [
        SavingsMeasureViewItem(id: "USD", name: "USD"),
        SavingsMeasureViewItem(id: "EUR", name: "EUR"),
        SavingsMeasureViewItem(id: "RUB", name: "RUB"),
        SavingsMeasureViewItem(id: "BYN", name: "BYN"),
        SavingsMeasureViewItem(id: "PLN", name: "PLN")
    ]

    @Published var dismissAction: Bool = false
    @Published var isValid: Bool = false

    // MARK: - Lifecycle

    public init(
        id: String,
        currency: String?,
        appState: Store<AppState>,
        service: AddSavingsTransactionDataServiceType
    ) {
        self.savingsId = id
        self.dataService = service

        if let currency = currency {
            self.currency = currencies.first(where: { $0.id == currency })
            self.currencyCanBeChanged = false
        }

        Publishers
            .CombineLatest($currency, $value)
            .sink(receiveValue: { [weak self] currency, value in
                self?.isValid = currency != nil && value?.isEmpty == false
            })
            .store(in: &cancellables)
    }

    deinit {
        Swift.print("[Deinit] AddSavingsTransactionViewModel")
    }

}

// MARK: - Internal

extension AddSavingsTransactionViewModel {

    func chooseCurrencyDropDownAction(_ item: SavingsMeasureViewItem) {
        currency = item
    }

    func addTransactionAction() async {
        guard isValid else { return }
        
        let data: [String: Any] = [
            "date": date,
            "value": Double(value ?? "") ?? 0,
            "isAdd": isAdd,
            "currency": currency?.id ?? ""
        ]

        do {
            try await dataService.addTransaction(savingsId: savingsId, data: data)
            onDisappear()
        } catch let error {
            Swift.print(error)
        }
    }

    func onAppear() {
        routingState.isPresented = true
    }

    func onDisappear() {
        routingState.isPresented = false
        cancellables.removeAll()
        state = .dismiss
    }

}
