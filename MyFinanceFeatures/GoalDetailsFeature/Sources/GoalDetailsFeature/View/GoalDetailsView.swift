import SwiftUI

import MyFinanceAssetsKit

public struct GoalDetailsView<EditGoal: View>: View {

    @ObservedObject var viewModel: GoalDetailsViewModel

    private var editGoalViewProvider: (_ id: String) -> EditGoal

    public init(
        viewModel: GoalDetailsViewModel,
        editGoalViewProvider: @escaping (_ id: String) -> EditGoal
    ) {
        self.viewModel = viewModel
        self.editGoalViewProvider = editGoalViewProvider
    }

    public var body: some View {
        content
            .sheet(
                isPresented: $viewModel.routingState.showModalSheet,
                content: {
                    modalSheet
                })
    }

    var content: some View {
        ZStack {
            Color.primaryBackground.ignoresSafeArea()
            text
                .navigationBarTitle(Text("Goal \(viewModel.id)"))
                .navigationBarItems(trailing: navBarButtons)
        }
    }

    var modalSheet: some View {
        switch viewModel.routingState.currentModalSheet {
        case .editGoal:
            return AnyView(editGoalViewProvider(viewModel.id))
        case .none:
            return AnyView(Text(""))
        }
    }

    var navBarButtons: some View {
        HStack {
            editButton
        }
    }

    var editButton: some View {
        Button(
            action: viewModel.editGoalAction,
            label: { Image(systemName: "pencil.circle").imageScale(.large) }
        )
    }

    var text: some View {
        Text("Goal Details ID: \(viewModel.id)").padding()
    }

}
