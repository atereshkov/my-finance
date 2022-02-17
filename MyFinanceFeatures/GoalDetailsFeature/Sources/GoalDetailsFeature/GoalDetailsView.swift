import SwiftUI

public struct GoalDetailsView: View {

    private let id: String

    public init(id: String) {
        self.id = id
    }

    public var body: some View {
        content
    }

    var content: some View {
        Text("Goal Details ID: \(id)").padding()
    }

}
