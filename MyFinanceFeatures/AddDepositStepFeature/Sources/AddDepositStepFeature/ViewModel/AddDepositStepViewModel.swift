import Foundation
import Combine

public class AddDepositStepViewModel: ObservableObject {

    private var cancellables: Set<AnyCancellable> = []
    private let dataService: AddDepositStepDataServiceType

    private let depositId: String

    // MARK: Input

    @Published var amount: String?
    @Published var date = Date()

    // MARK: Output

    @Published var routingState = AddDepositStepRouting()
    @Published var state: AddDepositStepViewState = .start

    public init(
        id: String,
        dataService: AddDepositStepDataServiceType
    ) {
        self.depositId = id
        self.dataService = dataService
    }

    func addDepositStepAction() async {
        let data: [String: Any] = [
            "value": Double(amount ?? "") ?? 0.0,
            "date": date
        ]

        do {
            try await dataService.addDepositStep(depositId: depositId, data: data)
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
    }

}
