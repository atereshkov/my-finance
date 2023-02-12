import Foundation

struct DepositPayoutDVO: Identifiable {
    let id = UUID()
    let date: Date
    let paid: Double
    let tax: Double
    let sum: Double
}
