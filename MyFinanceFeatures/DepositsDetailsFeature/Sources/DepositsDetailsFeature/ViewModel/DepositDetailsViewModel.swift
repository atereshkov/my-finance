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
    @Published var currency: String = ""
    @Published var startValue: String = ""
    @Published var balance: String = ""
    @Published var startDate: String = ""
    @Published var endDate: String = ""
    @Published var topUpEndDate: String = ""

    @Published var progressValue: Double = 0.0

    @Published var estimatedIncome: String = ""
    @Published var topUpMonthly: String = ""

    @Published var steps: [DepositStepDVO] = []
    @Published var payouts: [DepositPayoutDVO] = []

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

        Task {
            await loadSteps()
        }
    }

    deinit {
        Swift.print("[Deinit] DepositDetailsViewModel")
    }

}

// MARK: - Internal

extension DepositDetailsViewModel {

    func editDepositAction() {
        routingState.show(sheet: .editDeposit(id))
    }

    func deleteDepositAction() {
        guard let deposit = deposit else { return }
        routingState.show(alert: .confirmDeleteDeposit(deposit))
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

    func deleteDepositActionConfirmed(_ item: DepositDVO) async {
        do {
            try await dataService.deleteDeposit(depositId: id)
        } catch let error {
            Swift.print(error)
        }
    }

}

// MARK: - Private

private extension DepositDetailsViewModel {

    private func loadSteps() async {
        do {
            let steps = try await dataService.getDepositSteps(depositId: id)
            DispatchQueue.main.async {
                self.steps = steps
            }
        } catch let error {
            Swift.print(error)
        }
    }

    private func bind(_ deposit: DepositDVO) {
        bindDetails(deposit)
        bindStats(deposit)
        bindMonthlyPayout(deposit)
    }

    private func bindDetails(_ deposit: DepositDVO) {
        depositName = deposit.name
        currency = deposit.currency
        balance = deposit.balance.formattedAsCurrency() ?? ""
        startValue = deposit.startValue.formattedAsCurrency() ?? ""

        startDate = deposit.startDate.formatted(date: .numeric, time: .omitted)
        endDate = deposit.endDate.formatted(date: .numeric, time: .omitted)
        topUpEndDate = deposit.topUpEndDate.formatted(date: .numeric, time: .omitted)
    }

    private func bindStats(_ deposit: DepositDVO) {

    }

    private func bindMonthlyPayout(_ deposit: DepositDVO) {
        var current = Calendar.current.date(byAdding: .day, value: 15, to: deposit.startDate)!
        
        let months = Calendar.current.dateComponents([.month], from: deposit.startDate, to: deposit.endDate).month ?? 0
        var payPeriods = Double(min(months, 12))
        if months < 12 {
            payPeriods = Double(months * 2)
            // multiplying by two because twice a month payout
        }

        var i = 0
        while current < deposit.endDate {
            let prevPayout = i > 0 ? payouts[i - 1] : nil

            let paid: Double = (prevPayout?.sum ?? deposit.balance) * deposit.rate / 100 / payPeriods / 2

            let tax: Double = paid * deposit.tax / 100
            var sum = paid + (prevPayout?.sum ?? 0) - tax
            if i == 0 {
                sum += deposit.startValue
            }

            let dvo = DepositPayoutDVO(date: current, paid: paid, tax: tax, sum: sum)
            payouts.append(dvo)

            if i % 2 == 0 {
                current = Calendar.current.date(byAdding: .day, value: 15, to: current) ?? Date()
            } else {
                current = Calendar.current.dateInterval(of: .month, for: current)?.end ?? Date()
            }
            i += 1
        }
    }

}
