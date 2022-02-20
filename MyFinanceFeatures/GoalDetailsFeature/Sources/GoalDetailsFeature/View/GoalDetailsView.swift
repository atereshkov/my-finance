import SwiftUI

import MyFinanceComponentsKit
import MyFinanceAssetsKit

public struct GoalDetailsView<EditGoal: View, AddGoalStep: View>: View {

    @ObservedObject var viewModel: GoalDetailsViewModel

    private var editGoalViewProvider: (_ id: String) -> EditGoal
    private var addGoalStepViewProvider: (_ id: String) -> AddGoalStep

    public init(
        viewModel: GoalDetailsViewModel,
        editGoalViewProvider: @escaping (_ id: String) -> EditGoal,
        addGoalStepViewProvider: @escaping (_ id: String) -> AddGoalStep
    ) {
        self.viewModel = viewModel
        self.editGoalViewProvider = editGoalViewProvider
        self.addGoalStepViewProvider = addGoalStepViewProvider
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
            list
                .navigationBarTitle(Text("Goal \(viewModel.id)"))
                .navigationBarItems(trailing: navBarButtons)
        }
    }

    var modalSheet: some View {
        switch viewModel.routingState.currentModalSheet {
        case .editGoal:
            return AnyView(editGoalViewProvider(viewModel.id))
        case .addGoalStep:
            return AnyView(addGoalStepViewProvider(viewModel.id))
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

    var list: some View {
        List {
            chartSection
            detailsSection
            statsSection
            stepsSection
        }
    }

    var addGoalStepButton: some View {
        Button(
            action: viewModel.addStepGoalAction,
            label: {
                HStack {
                    Image(systemName: "plus").imageScale(.large)
                    Text("Add step goal")
                }
            }
        )
    }

    var chartSection: some View {
        Section {
            Text("Chart")
        }
    }

    var detailsSection: some View {
        Section {
            VStack(alignment: .leading) {
                HStack {
                    Text("Goal: \(viewModel.goalValue)")
                    Spacer()
                    MeasureBadgeView(title: viewModel.goalMeasure)
                }
                Text("Start: \(viewModel.startValue)")
                    .padding(.bottom, 3)
                Text("Current: \(viewModel.currentValue)")
            }
        }
    }

    var statsSection: some View {
        Section {
            VStack(alignment: .leading) {
                Text("Avg per day: ...")
                Text("Avg per month: ...")
                Text("Ahead of goal: ...")
                Text("Top-up ... monthly to reach the goal")
            }
        }
    }

    var stepsSection: some View {
        Section {
            addGoalStepButton
            HStack {
                Image(systemName: "calendar")
                Text("02/14/2022")
                Spacer()
                Text("+ 200")
            }
            .swipeActions {
                Button("Delete") {

                }
                .tint(.red)
                Button("Edit") {

                }
                .tint(.blue)
            }
            HStack {
                Image(systemName: "calendar")
                Text("02/14/2022")
                Spacer()
                Text("+ 200")
            }
        }
    }

}
