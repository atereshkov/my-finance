import Foundation

public class SavingsListViewModel: ObservableObject {

    // MARK: Output

    @Published var savings: [SavingsViewItem] = [
        SavingsViewItem(id: "1", name: "Savings 1"),
        SavingsViewItem(id: "2", name: "Savings 2"),
        SavingsViewItem(id: "3", name: "Savings 3")
    ]

    @Published var routingState = SavingsListRouting()

    public init() {
//        cancelBag.collect {
//            $routingState
//                .sink { session.appState[\.routing.home] = $0 }
//
//            session.appState.map(\.data.portfolios)
//                .removeDuplicates()
//                .assign(to: \.portfolios, on: self)
//        }
    }
}
