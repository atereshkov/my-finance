import SwiftUI

struct SavingsRowView: View {
    var item: SavingsViewItem

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.id)
                Text(item.name)
                Divider()
            }
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity)
    }
}

#if DEBUG
struct SavingsRowViewPreviews: PreviewProvider {
    static var previews: some View {
        SavingsRowView(item: SavingsViewItem(id: "1", name: "Name1"))
            .previewLayout(.fixed(width: 375, height: 40))
    }
}
#endif
