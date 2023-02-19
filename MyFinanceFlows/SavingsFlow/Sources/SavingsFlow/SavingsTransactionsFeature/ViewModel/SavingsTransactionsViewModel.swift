import Foundation
import Combine

import AppState
import MyFinanceDomain

public class SavingsTransactionsViewModel: ObservableObject {

    private var cancellables: Set<AnyCancellable> = []
    private let dataService: SavingsTransactionsDataServiceType

    @Published private var id: String
    @Published private var parentId: String
    @Published private var savings: SavingsTransactionDVO?

    // MARK: Output

    @Published var routingState = SavingsTransactionsRouting()

    @Published var savingsName: String = ""
    @Published var currency: String = ""
    @Published var startValue: String = ""
    @Published var currentValue: String = ""
    @Published var startDate: String = ""

    @Published var progressValue: Double = 0.0

    @Published var estimatedSum: String = ""

    @Published var steps: [SavingsTransactionDVO] = []

    public init(
        id: String,
        parentId: String,
        appState: Store<AppState>,
        dataService: SavingsTransactionsDataServiceType
    ) {
        self.id = id
        self.parentId = parentId
        self.dataService = dataService

//        appState.map(\.data.savings)
//            .compactMap { $0 }
//            .sink { [weak self] savings in
//                self?.savings = savings.first(where: { $0.id == id })
//            }
//            .store(in: &cancellables)
//
//        $savings
//            .compactMap { $0 }
//            .sink { [weak self] savings in
//                self?.bind(savings)
//            }
//            .store(in: &cancellables)

        Task {
            await loadTransactions()
        }
    }

    deinit {
        Swift.print("[Deinit] SavingsTransactionsViewModel")
    }

}

// MARK: - Internal

extension SavingsTransactionsViewModel {

    func deleteAllTransactionsAction() {
//        guard let savings = savings else { return }
//        routingState.show(alert: .confirmDeleteAllTransactions(savings))
    }

    func addTransactionAction() {
        routingState.show(sheet: .addTransaction(id))
    }

    func editTransactionAction(_ item: SavingsTransactionDVO) {
        routingState.show(sheet: .editTransaction(item, id))
    }

    func deleteTransactionAction(_ item: SavingsTransactionDVO) {
        routingState.show(alert: .confirmDeleteTransaction(item))
    }

    func deleteTransactionActionConfirmed(_ item: SavingsTransactionDVO) async {
        do {
            try await dataService.deleteTransaction(id: item.id, value: item.value, savingsId: id)
        } catch let error {
            Swift.print(error)
        }
    }

    func deleteAllTransactionsActionConfirmed(_ item: SavingsDVO) async {
//        do {
//            try await dataService.deleteAllTransactions(savingsId: id)
//        } catch let error {
//            Swift.print(error)
//        }
    }

}

// MARK: - Private

private extension SavingsTransactionsViewModel {

    private func loadTransactions() async {
        do {
            let steps = try await dataService.getTransactions(savingsId: id)
            DispatchQueue.main.async {
                self.steps = steps
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
//        currency = savings.currency
//        currentValue = savings.currentValue.formattedAsCurrency() ?? ""
//        startValue = savings.startValue.formattedAsCurrency() ?? ""

        startDate = savings.startDate.formatted(date: .numeric, time: .omitted)
    }

    private func bindStats(_ savings: SavingsDVO) {
//        estimatedSum = "\(savings.balance + savings.incomeWithoutTaxes)"
    }

}
