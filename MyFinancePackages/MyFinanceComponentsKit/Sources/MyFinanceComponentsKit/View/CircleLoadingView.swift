import SwiftUI

public struct CircleLoadingView: View {

    @State private var shouldAnimate = false

    private var color: Color

    public init(color: Color) {
        self.color = color
    }

    public var body: some View {
        HStack {
            Circle()
                .fill(color)
                .frame(width: 14, height: 14)
                .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                .animation(Animation.easeInOut(duration: 0.5).repeatForever(), value: shouldAnimate)
            Circle()
                .fill(color)
                .frame(width: 14, height: 14)
                .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.3), value: shouldAnimate)
            Circle()
                .fill(color)
                .frame(width: 14, height: 14)
                .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.6), value: shouldAnimate)
        }
        .onAppear {
            self.shouldAnimate = true
        }
    }

}
