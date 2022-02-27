import Foundation

public extension Double {

    func formattedAsCurrency() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 0
        return formatter.string(for: self)
    }

}
