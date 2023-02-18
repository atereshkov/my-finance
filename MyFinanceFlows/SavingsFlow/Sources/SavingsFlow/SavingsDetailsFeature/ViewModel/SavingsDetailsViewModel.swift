import Foundation
import Combine

import AppState
import MyFinanceDomain

public class SavingsDetailsViewModel: ObservableObject {

    private var cancellables: Set<AnyCancellable> = []
    private let dataService: SavingsDataServiceType

    @Published private var id: String
    @Published private var savings: SavingsDVO?

    // MARK: Output

    @Published var routingState = SavingsDetailsRouting()

    @Published var savingsName: String = ""
    @Published var currency: String = ""
    @Published var startValue: String = ""
    @Published var currentValue: String = ""
    @Published var startDate: String = ""

    @Published var progressValue: Double = 0.0

    @Published var estimatedSum: String = ""

    @Published var steps: [SavingsStepDVO] = []

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
            await loadSteps()
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

    func addSavingsStepAction() {
        routingState.show(sheet: .addSavingsStep(id))
    }

    func editStepAction(_ item: SavingsStepDVO) {
        routingState.show(sheet: .editSavingsStep(item, id))
    }

    func deleteStepAction(_ item: SavingsStepDVO) {
        routingState.show(alert: .confirmDeleteStep(item))
    }

    func deleteStepActionConfirmed(_ item: SavingsStepDVO) async {
        do {
            try await dataService.deleteSavingsStep(stepId: item.id, value: item.value, savingsId: id)
        } catch let error {
            Swift.print(error)
        }
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

    private func loadSteps() async {
        do {
            let steps = try await dataService.getSavingsSteps(savingsId: id)
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
        currency = savings.currency
        currentValue = savings.currentValue.formattedAsCurrency() ?? ""
        startValue = savings.startValue.formattedAsCurrency() ?? ""

        startDate = savings.startDate.formatted(date: .numeric, time: .omitted)
    }

    private func bindStats(_ savings: SavingsDVO) {
//        estimatedSum = "\(savings.balance + savings.incomeWithoutTaxes)"
    }

}
