import Foundation

enum NavigationDestinationType {
    case savingsDetails
    case savingsTransactions
}

struct NavigationDestination: Hashable {
    let id: String
    let parentId: String?
    let type: NavigationDestinationType
}
