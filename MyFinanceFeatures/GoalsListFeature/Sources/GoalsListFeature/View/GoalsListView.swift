import SwiftUI

import MyFinanceAssetsKit
import MyFinanceDomain

public struct GoalsListView<GoalDetails: View, AddGoal: View>: View {

    @ObservedObject var viewModel: GoalsListViewModel

    private var goalDetailsViewProvider: (_ id: String) -> GoalDetails
    private var addGoalViewProvider: () -> AddGoal

    public init(
        viewModel: GoalsListViewModel,
        goalDetailsViewProvider: @escaping (_ id: String) -> GoalDetails,
        addGoalViewProvider: @escaping () -> AddGoal
    ) {
        self.viewModel = viewModel
        self.goalDetailsViewProvider = goalDetailsViewProvider
        self.addGoalViewProvider = addGoalViewProvider
    }

    public var body: some View {
        content
            .sheet(
                isPresented: $viewModel.routingState.showModalSheet,
                content: {
                    modalSheet
                })
    }

}

extension GoalsListView {

    var content: some View {
        NavigationView {
            ZStack {
                Color.primaryBackground.ignoresSafeArea()
                goals
                    .padding([.leading, .trailing], 18)
                    .navigationBarTitle(Text("My Goals"), displayMode: .inline)
                    .navigationBarItems(trailing: navBarButtons)
            }
        }
    }

    var modalSheet: some View {
        switch viewModel.routingState.currentModalSheet {
        case .addGoal:
            return AnyView(addGoalViewProvider())
        case .none:
            return AnyView(Text(""))
        }
    }

    var navBarButtons: some View {
        HStack {
            dashboardButton
            addButton
        }
    }

    var addButton: some View {
        Button(
            action: viewModel.addGoalAction,
            label: { Image(systemName: "plus").imageScale(.large) }
        )
    }

    var dashboardButton: some View {
        Button(
            action: { },
            label: { Image(systemName: "arrow.up.right").imageScale(.large) }
        )
    }

    var goals: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.goals) { item in
                    NavigationLink(
                        destination: goalDetailsView(item),
                        tag: item.id,
                        selection: $viewModel.routingState.goalsDetails
                    ) {
                        GoalsRowView(item: item)
                    }
                }
            }
        }
    }

    func goalDetailsView(_ item: GoalDVO) -> some View {
        return goalDetailsViewProvider(item.id)
    }

}
