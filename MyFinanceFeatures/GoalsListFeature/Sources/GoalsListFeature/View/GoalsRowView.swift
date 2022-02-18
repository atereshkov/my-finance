import SwiftUI

import MyFinanceAssetsKit

struct GoalsRowView: View {
    var item: GoalsViewItem

    var body: some View {
        ZStack(alignment: .leading) {
            LinearGradient(
                gradient: Gradient(colors: [.primaryBackground80, .primaryBackground90]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            HStack {
                VStack(alignment: .center) {
                    CircleView(title: "99%")
                        .frame(width: 60, height: 60, alignment: .center)
                    MeasureBadgeView(title: "$")
                }

                VStack(alignment: .leading) {
                    Text(item.name)
                        .foregroundColor(.labelPrimaryText)
                        .font(.headline)
                        .fontWeight(.bold)
                        .lineLimit(2)
                        .padding(.bottom, 5)

                    Text("Goal")
                        .foregroundColor(.labelPrimaryText)
                        .padding(.bottom, 5)

                    Text("Start")
                        .foregroundColor(.labelPrimaryText)
                        .padding(.bottom, 5)

                    Text("Done")
                        .foregroundColor(.labelPrimaryText)
                        .padding(.bottom, 5)
                }
                .padding(.horizontal, 5)
            }
            .padding(15)
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct MeasureBadgeView: View {

    var title: String
    var fontSize: CGFloat = 12.0

    var body: some View {
        ZStack {
            Text(title)
                .font(.system(size: fontSize, weight: .regular))
                .lineLimit(1)
                .foregroundColor(.labelPrimaryText)
                .padding(5)
                .background(Color.green)
                .cornerRadius(5)
        }
    }
}

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

#if DEBUG
struct GoalsRowViewPreviews: PreviewProvider {
    static var previews: some View {
        Group {
            GoalsRowView(item: GoalsViewItem(id: "1", name: "Name1"))
                .previewLayout(.fixed(width: 375, height: 100))
        }
    }
}
#endif
