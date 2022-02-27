import SwiftUI

struct CircleView: View {

    var title: String

    var body: some View {
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
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.labelPrimaryText)
            }
        }
    }

}
