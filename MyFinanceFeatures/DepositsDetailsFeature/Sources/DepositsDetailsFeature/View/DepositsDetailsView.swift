import SwiftUI

public struct DepositsDetailsView: View {

    private let id: String

    public init(id: String) {
        self.id = id
    }

    public var body: some View {
        content
    }

    var content: some View {
        Text("Deposits Details ID: \(id)").padding()
    }

}
