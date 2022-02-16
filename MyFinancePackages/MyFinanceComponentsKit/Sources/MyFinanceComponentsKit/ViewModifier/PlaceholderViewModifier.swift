import SwiftUI

public struct PlaceHolder<T: View>: ViewModifier {
    var placeHolder: T
    var show: Bool

    public func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if show {
                placeHolder
                    .foregroundColor(.white)
                    .padding([.bottom], 9)
            }
            content
        }
    }
}

extension View {
    public func placeHolder<T:View>(_ holder: T, show: Bool) -> some View {
        self.modifier(PlaceHolder(placeHolder: holder, show: show))
    }
}
