import SwiftUI

public struct GoalProgressView: View {
    @Binding var value: Double

    public init(value: Binding<Double>) {
        self._value = value
    }

    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemTeal))

                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color(UIColor.systemBlue), Color(UIColor.systemBlue)]), startPoint: .leading, endPoint: .trailing)
                    )
                    .frame(width: min(CGFloat(self.value) * geometry.size.width, geometry.size.width), height: geometry.size.height
                    )
                    .animation(.linear, value: true)
            }.cornerRadius(45.0)
        }
    }
}
