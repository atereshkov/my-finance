import SwiftUI

public struct PrimaryTextField: TextFieldStyle {

    public init() { }

    public func _body(configuration: TextField<Self._Label>) -> some View {
        VStack {
            configuration
                .colorMultiply(.white)
                .foregroundColor(.white)

            Rectangle()
                .frame(height: 1, alignment: .bottom)
                .foregroundColor(.white)
        }
    }
}
