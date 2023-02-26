import SwiftUI

import MyFinanceDomain

struct SavingsRowView: View {
    var item: SavingsDVO

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                Text(item.description)
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
        SavingsRowView(item: SavingsDVO(id: "1", name: "Name1"))
            .previewLayout(.fixed(width: 375, height: 40))
    }
}
#endif
