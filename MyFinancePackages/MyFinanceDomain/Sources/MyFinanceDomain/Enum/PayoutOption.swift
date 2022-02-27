public enum PayoutOption {
    case weekly
    case twiceMonth
    case monthly
    case eachTwoMonths
    case quarterly
    case custom

    public func localized() -> String {
        switch self {
        case .weekly:
            return "Weekly"
        case .twiceMonth:
            return "Twice a month"
        case .monthly:
            return "Monthly"
        case .eachTwoMonths:
            return "Each two months"
        case .quarterly:
            return "Quarterly"
        case .custom:
            return "Custom"
        }
    }

    public func dtoValue() -> String {
        switch self {
        case .weekly:
            return "weekly"
        case .twiceMonth:
            return "twice_a_month"
        case .monthly:
            return "monthly"
        case .eachTwoMonths:
            return "each_2_months"
        case .quarterly:
            return "quarterly"
        case .custom:
            return "custom"
        }
    }
}
