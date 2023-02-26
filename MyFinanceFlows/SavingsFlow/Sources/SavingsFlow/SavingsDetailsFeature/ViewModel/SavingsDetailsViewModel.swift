import Foundation
import Combine

import AppState
import MyFinanceDomain

public class SavingsDetailsViewModel: ObservableObject {

    private var cancellables: Set<AnyCancellable> = []
    private let dataService: SavingsDataServiceType

    // MARK: - Input

    @Published private(set) var id: String
    @Published private var savings: SavingsDVO?

    // MARK: - Output

    @Published var routingState = SavingsDetailsRouting()

    @Published var savingsName: String = ""
    @Published var description: String = ""
    @Published var startDate: String = ""

    @Published var currencies: [SavingsCurrencyValueItem] = []

    @Published var transactions: [SavingsTransactionDVO] = []

    @Published var chartData: [(currency: String, data: [SavingsTransactionDVO])] = []

    public init(
        id: String,
        appState: Store<AppState>,
        dataService: SavingsDataServiceType
    ) {
        self.id = id
        self.dataService = dataService

        appState.map(\.data.savings)
            .compactMap { $0 }
            .sink { [weak self] savings in
                self?.savings = savings.first(where: { $0.id == id })
            }
            .store(in: &cancellables)

        $savings
            .compactMap { $0 }
            .sink { [weak self] savings in
                self?.bind(savings)
            }
            .store(in: &cancellables)

        Task {
            await loadTransactions()
        }
    }

    deinit {
        Swift.print("[Deinit] SavingsDetailsViewModel")
    }

}

// MARK: - Internal

extension SavingsDetailsViewModel {

    func editSavingsAction() {
        routingState.show(sheet: .editSavings(id))
    }

    func deleteSavingsAction() {
        guard let savings = savings else { return }
        routingState.show(alert: .confirmDeleteSavings(savings))
    }

    func addTransactionAction() {
        routingState.show(sheet: .addTransaction(id))
    }

    func deleteSavingsActionConfirmed(_ item: SavingsDVO) async {
        do {
            try await dataService.deleteSavings(savingsId: id)
        } catch let error {
            Swift.print(error)
        }
    }

}

// MARK: - Private

private extension SavingsDetailsViewModel {

    private func loadTransactions() async {
        let currencies = savings?.currentValues.map { $0.key }
        guard let currencies else { return }

        do {
            let transactions = try await dataService.getTransactions(savingsId: id, currencies: currencies)
            DispatchQueue.main.async {
                self.transactions = transactions
                for currency in currencies {
                    let data = transactions.filter { $0.currency == currency }
                    self.chartData.append((currency: currency, data: data))
                }
            }
        } catch let error {
            Swift.print(error)
        }
    }

    private func bind(_ savings: SavingsDVO) {
        bindDetails(savings)
        bindStats(savings)
    }

    private func bindDetails(_ savings: SavingsDVO) {
        savingsName = savings.name
        description = savings.description

        currencies = savings.currentValues
            .map { .init(currency: $0.0, value: $0.1) }
            .sorted(by: { $0.value > $1.value })

        startDate = savings.startDate.formatted(date: .numeric, time: .omitted)
    }

    private func bindStats(_ savings: SavingsDVO) {
//        estimatedSum = "\(savings.balance + savings.incomeWithoutTaxes)"
    }

}
