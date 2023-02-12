import SwiftUI

import MyFinanceDomain

struct DepositsRowView: View {
    var item: DepositDVO

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
struct DepositsRowViewPreviews: PreviewProvider {
    static var previews: some View {
        DepositsRowView(item: DepositDVO(id: "1", name: "Name1"))
            .previewLayout(.fixed(width: 375, height: 40))
    }
}
#endif
