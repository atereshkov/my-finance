import Foundation
import Combine

import AppState

public class AddSavingsViewModel: ObservableObject {

    private var cancellables: Set<AnyCancellable> = []

    private let dataService: AddSavingsDataServiceType

    // MARK: Input

    @Published var name: String?
    @Published var description: String?

    @Published var savingsMeasureIndex: Int = 0
    @Published var startDate = Date()

    @Published var currencyFields: [CurrencyViewItem] = []

    // MARK: Output

    @Published var routingState = AddSavingsRouting()
    @Published var state: AddSavingsViewState = .start

    @Published var title: String?

    @Published var currencies = [
        SavingsMeasureViewItem(id: "USD", name: "USD"),
        SavingsMeasureViewItem(id: "EUR", name: "EUR"),
        SavingsMeasureViewItem(id: "RUB", name: "RUB"),
        SavingsMeasureViewItem(id: "BYN", name: "BYN"),
        SavingsMeasureViewItem(id: "PLN", name: "PLN")
    ]

    @Published var dismissAction: Bool = false

    // MARK: - Lifecycle

    public init(
        appState: Store<AppState>,
        service: AddSavingsDataService
    ) {
        self.dataService = service

        $name
            .sink { [weak self] in self?.title = $0 ?? "New Savings" }
            .store(in: &cancellables)
    }

    deinit {
        Swift.print("[Deinit] AddSavingsViewModel")
    }

}

// MARK: - Internal

extension AddSavingsViewModel {

    func chooseCurrencyDropDownAction(_ item: SavingsMeasureViewItem, currency: CurrencyViewItem) {
        guard let index = currencyFields.firstIndex(where: { item.id == $0.id }) else { return }
        currencyFields[index].currency = item.name
    }

    func addCurrencyFieldAction() {
        currencyFields.append(.init(id: UUID().uuidString, currency: "USD", value: 0.0))
    }

    func updateCurrencyFieldValue(to value: Double, currency: CurrencyViewItem) {
        guard let index = currencyFields.firstIndex(where: { currency.id == $0.id }) else { return }
        currencyFields[index].value = value
    }

    func addSavingsAction() async {
        let data: [String: Any] = [
            "name": name ?? "",
            "description": description ?? "",
            "startDate": startDate
        ]

        do {
            try await dataService.addSavings(data: data)
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
