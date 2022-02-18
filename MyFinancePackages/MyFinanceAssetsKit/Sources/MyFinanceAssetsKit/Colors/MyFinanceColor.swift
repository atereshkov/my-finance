import SwiftUI

public extension Color {
    static let primaryColor = Color("primaryColor", bundle: Bundle.module)
    static let secondaryColor = Color("secondaryColor", bundle: Bundle.module)

    static let primaryBackground = Color("primaryBackgroundColor", bundle: Bundle.module)
    static let primaryBackground80 = Color("primaryBackgroundColor80", bundle: Bundle.module)
    static let primaryBackground90 = Color("primaryBackgroundColor90", bundle: Bundle.module)
    static let secondaryBackground = Color("secondaryBackgroundColor", bundle: Bundle.module)

    static let labelPrimaryText = Color("labelPrimaryText", bundle: Bundle.module)
    static let labelSecondaryText = Color("labelSecondaryText", bundle: Bundle.module)
    static let labelAccentText = Color("labelAccentText", bundle: Bundle.module)
}
