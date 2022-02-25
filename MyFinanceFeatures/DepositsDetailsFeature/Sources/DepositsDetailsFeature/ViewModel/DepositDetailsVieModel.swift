import Foundation
import Combine

import AppState
import MyFinanceDomain

public class DepositDetailsViewModel: ObservableObject {

    private var cancellables: Set<AnyCancellable> = []
    private let dataService: DepositDataServiceType

    @Published private var id: String
    @Published private var deposit: DepositDVO?

    // MARK: Output

    @Published var routingState = DepositDetailsRouting()

    @Published var depositName: String = ""
    @Published var goalMeasure: String = ""
    @Published var goalValue: String = ""
    @Published var startValue: String = ""
    @Published var currentValue: String = ""
    @Published var startDate: String = ""
    @Published var endDate: String = ""

    @Published var progressValue: Double = 0.0
    @Published var percentCompletedValue: Int = 0

    @Published var averagePerMonth: String = ""
    @Published var topUpMonthly: String = ""

    @Published var steps: [DepositStepDVO] = []

    public init(
        id: String,
        appState: Store<AppState>,
        dataService: DepositDataServiceType
    ) {
        self.id = id
        self.dataService = dataService

        appState.map(\.data.deposits)
            .compactMap { $0 }
            .sink { [weak self] deposits in
                self?.deposit = deposits.first(where: { $0.id == id })
            }
            .store(in: &cancellables)

        $deposit
            .compactMap { $0 }
            .sink { [weak self] deposit in
                self?.bind(deposit)
            }
            .store(in: &cancellables)

//        do {
//            self.steps = try await dataService.getDepositSteps(depositId: id)
//        } catch let error {
//            Swift.print(error)
//        }
    }

}

extension DepositDetailsViewModel {

    func editDepositAction() {
        routingState.show(sheet: .editDeposit(id))
    }

    func addDepositStepAction() {
        routingState.show(sheet: .addDepositStep(id))
    }

    func editStepAction(_ item: DepositStepDVO) {
        routingState.show(sheet: .editDepositStep(item, id))
    }

    func deleteStepAction(_ item: DepositStepDVO) {
        routingState.show(alert: .confirmDeleteStep(item))
    }

    func deleteStepActionConfirmed(_ item: DepositStepDVO) async {
        do {
            try await dataService.deleteDepositStep(stepId: item.id, value: item.value, depositId: id)
        } catch let error {
            Swift.print(error)
        }
    }

}

private extension DepositDetailsViewModel {

    private func bind(_ deposit: DepositDVO) {
        bindDetails(deposit)
        bindStats(deposit)
    }

    private func bindDetails(_ deposit: DepositDVO) {
        depositName = deposit.name
    }

    private func bindStats(_ deposit: DepositDVO) {

    }

}
