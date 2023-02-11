import SwiftUI

public struct CircleView: View {

    private var title: String
    private var fontSize: CGFloat = 20.0

    public init(title: String, fontSize: CGFloat = 20.0) {
        self.title = title
        self.fontSize = fontSize
    }

    public var body: some View {
        ZStack {
            Circle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [.secondaryColor, .secondaryColor]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
            VStack {
                Text(title)
                    .font(.system(size: fontSize, weight: .bold))
                    .foregroundColor(.labelPrimaryText)
            }
        }
    }

}
