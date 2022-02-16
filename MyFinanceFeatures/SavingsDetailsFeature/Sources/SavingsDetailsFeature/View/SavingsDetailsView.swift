import SwiftUI

public struct SavingsDetailsView: View {

    private let id: String

    public init(id: String) {
        self.id = id
    }

    public var body: some View {
        content
    }

    var content: some View {
        Text("Savings Details ID: \(id)").padding()
    }

}
