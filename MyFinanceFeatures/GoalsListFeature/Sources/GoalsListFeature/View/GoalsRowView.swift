import SwiftUI

struct GoalsRowView: View {
    var item: GoalsViewItem

    var body: some View {
        ZStack(alignment: .leading) {
            Color.gray
            HStack {
                CircleView(title: "99%")
                    .frame(width: 60, height: 60, alignment: .center)

                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.headline)
                        .fontWeight(.bold)
                        .lineLimit(2)
                        .padding(.bottom, 5)

                    Text(item.name)
                        .padding(.bottom, 5)

                    HStack(alignment: .center) {
                        Image(systemName: "mappin")
                        Text(item.name)
                    }
                    .padding(.bottom, 5)

//                    HStack {
//                        ForEach(categories, id: \.self) { category in
//                            CategoryPill(title: category)
//                        }
//                    }
                }
                .padding(.horizontal, 5)
            }
            .padding(15)
        }
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

struct CategoryPill: View {

    var title: String
    var fontSize: CGFloat = 12.0

    var body: some View {
        ZStack {
            Text(title)
                .font(.system(size: fontSize, weight: .regular))
                .lineLimit(1)
                .foregroundColor(.white)
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
                        gradient: Gradient(colors: [.orange, .blue]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
            VStack {
                Text(title)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
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
