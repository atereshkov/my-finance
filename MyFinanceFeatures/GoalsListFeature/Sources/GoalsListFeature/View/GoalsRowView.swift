import SwiftUI

import MyFinanceComponentsKit
import MyFinanceAssetsKit
import MyFinanceDomain

struct GoalsRowView: View {
    var item: GoalDVO

    var body: some View {
        ZStack(alignment: .leading) {
            LinearGradient(
                gradient: Gradient(colors: [.primaryBackground80, .primaryBackground90]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            HStack {
                CircleView(title: item.percentCompleted ?? "0%")
                    .frame(width: 60, height: 60, alignment: .center)

                VStack(alignment: .leading) {
                    HStack {
                        Text(item.currentValue.formattedAsCurrency() ?? "")
                            .foregroundColor(.labelPrimaryText)
                            .font(.headline)
                            .fontWeight(.bold)
                            .lineLimit(2)
                            .padding(.bottom, 5)
                        Spacer()
                        MeasureBadgeView(title: item.measure)
                    }

                    HStack {
                        Text(item.startValue.formattedAsCurrency() ?? "")
                            .font(.system(size: 12.0, weight: .regular))
                            .foregroundColor(.labelPrimaryText)
                        Spacer()
                        Text(item.goalValue.formattedAsCurrency() ?? "")
                            .font(.system(size: 12.0, weight: .regular))
                            .foregroundColor(.labelPrimaryText)
                    }
                    GoalListProgressView(value: item.progressValue).frame(height: 20)
                    HStack {
                        Text(item.startDate.formatted(date: .numeric, time: .omitted))
                            .font(.system(size: 11.0, weight: .regular))
                            .foregroundColor(.labelPrimaryText)
                        Spacer()
                        Text(item.endDate.formatted(date: .numeric, time: .omitted))
                            .font(.system(size: 11.0, weight: .regular))
                            .foregroundColor(.labelPrimaryText)
                    }
                    .padding(.bottom, 2)

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

#if DEBUG
struct GoalsRowViewPreviews: PreviewProvider {
    static var previews: some View {
        Group {
            GoalsRowView(item: GoalDVO(id: "1", name: "Name1"))
                .previewLayout(.fixed(width: 375, height: 100))
        }
    }
}
#endif
