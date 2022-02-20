import SwiftUI

import MyFinanceAssetsKit

public struct MeasureBadgeView: View {

    private var title: String
    private var fontSize: CGFloat = 12.0

    public init(title: String, fontSize: CGFloat = 12.0) {
        self.title = title
        self.fontSize = fontSize
    }

    public var body: some View {
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
