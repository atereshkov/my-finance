import Foundation
import Combine

import AppState

public class AddSavingsViewModel: ObservableObject {

    private var cancellables: Set<AnyCancellable> = []

    private let dataService: AddSavingsDataServiceType

    // MARK: Input

    @Published var name: String?
    @Published var goal: String?
    @Published var start: String?
    @Published var current: String?

    @Published var savingsMeasureIndex: Int = 0
    @Published var startDate = Date()
    @Published var endDate = Date()

    // MARK: Output

    @Published var routingState = AddSavingsRouting()
    @Published var state: AddSavingsViewState = .start

    @Published var title: String?

    @Published var savingsMeasureOptions = [
        SavingsMeasureViewItem(id: "USD", name: "USD"),
        SavingsMeasureViewItem(id: "EUR", name: "EUR"),
        SavingsMeasureViewItem(id: "RUB", name: "RUB"),
        SavingsMeasureViewItem(id: "BYN", name: "BYN"),
        SavingsMeasureViewItem(id: "PLN", name: "PLN"),
        SavingsMeasureViewItem(id: "percent", name: "%")
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

    func addSavingsAction() async {
        let data: [String: Any] = [
            "name": name ?? "",
            "measure": savingsMeasureOptions[savingsMeasureIndex].id,
            "goalValue": Double(goal ?? "") ?? 0,
            "startValue": Double(start ?? "") ?? 0,
            "currentValue": Double(current ?? "") ?? 0,
            "startDate": startDate,
            "endDate": endDate
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
