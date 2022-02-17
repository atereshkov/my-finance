import Foundation

public class DepositsListViewModel: ObservableObject {

    // MARK: Output

    @Published var deposits: [DepositsViewItem] = [
        DepositsViewItem(id: "1", name: "Deposit 1"),
        DepositsViewItem(id: "2", name: "Deposit 2"),
        DepositsViewItem(id: "3", name: "Deposit 3"),
        DepositsViewItem(id: "4", name: "Deposit 4"),
        DepositsViewItem(id: "5", name: "Deposit 5"),
        DepositsViewItem(id: "6", name: "Deposit 6")
    ]

    @Published var routingState = DepositsListRouting()

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
