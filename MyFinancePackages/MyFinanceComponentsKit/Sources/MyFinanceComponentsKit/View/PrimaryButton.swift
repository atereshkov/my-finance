import SwiftUI

public struct PrimaryButton: ButtonStyle {

    public init() { }

    public func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .font(.system(size: 16, weight: .semibold))
//            .background(Color(Asset.Colors.primaryLight.color))
            .background(.orange)
            .cornerRadius(4)
            .shadow(color: Color.black.opacity(0.05), radius: 7, x: 0, y: 6)
    }
}
