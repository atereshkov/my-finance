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
                VStack {

                    MeasureBadgeView(title: "USD")
                    CircleView(title: "99%")
                        .frame(width: 60, height: 60, alignment: .center)
                }

                VStack(alignment: .leading) {
                    HStack {
                        Text("5000 by 31/12/2022")
                            .foregroundColor(.labelPrimaryText)
                            .font(.headline)
                            .fontWeight(.bold)
                            .lineLimit(2)
                            .padding(.bottom, 5)
                    }

                    Text("Start $ 1000 - 01/01/2022")
                        .foregroundColor(.labelPrimaryText)
                        .padding(.bottom, 5)

                    Text("Done $ 1500")
                        .foregroundColor(.labelPrimaryText)
                        .padding(.bottom, 5)

                    Text(item.name)
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
