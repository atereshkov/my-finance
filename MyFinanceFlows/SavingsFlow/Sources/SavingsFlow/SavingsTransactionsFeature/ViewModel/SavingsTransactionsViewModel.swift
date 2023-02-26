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

    @Published var title: String = ""

    @Published var transactions: [SavingsTransactionDVO] = []

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

        self.title = id

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
        routingState.show(sheet: .addTransaction(id, id))
    }

    func editTransactionAction(_ item: SavingsTransactionDVO) {
        routingState.show(sheet: .editTransaction(item, id))
    }

    func deleteTransactionAction(_ item: SavingsTransactionDVO) {
        routingState.show(alert: .confirmDeleteTransaction(item))
    }

    func deleteTransactionActionConfirmed(_ item: SavingsTransactionDVO) async {
        do {
            try await dataService.deleteTransaction(id: item.id, value: item.value, currency: item.currency, isAdd: item.isAdd, savingsId: parentId)
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
            let transactions = try await dataService.getTransactions(savingsId: parentId, currency: id)
            DispatchQueue.main.async {
                self.transactions = transactions
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
//        savingsName = savings.name
//        currency = savings.currency
//        currentValue = savings.currentValue.formattedAsCurrency() ?? ""
//        startValue = savings.startValue.formattedAsCurrency() ?? ""

//        startDate = savings.startDate.formatted(date: .numeric, time: .omitted)
    }

    private func bindStats(_ savings: SavingsDVO) {
//        estimatedSum = "\(savings.balance + savings.incomeWithoutTaxes)"
    }

}
