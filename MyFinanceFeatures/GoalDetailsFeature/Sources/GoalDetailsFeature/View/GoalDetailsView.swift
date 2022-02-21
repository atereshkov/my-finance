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
        case .editGoal(let id):
            return AnyView(editGoalViewProvider(id))
        case .addGoalStep(let id):
            return AnyView(addGoalStepViewProvider(id))
        case .editGoalStep:
            return AnyView(EmptyView())
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
                    Text("Current: \(viewModel.currentValue) (\(viewModel.percentCompletedValue)%)")
                    Spacer()
                    MeasureBadgeView(title: viewModel.goalMeasure)
                }
            }
            VStack(alignment: .leading) {
                HStack {
                    Text(viewModel.startValue)
                        .font(.system(size: 12.0, weight: .regular))
                    Spacer()
                    Text(viewModel.goalValue)
                        .font(.system(size: 12.0, weight: .regular))
                }
                GoalProgressView(value: $viewModel.progressValue).frame(height: 20)
                HStack {
                    Text(viewModel.startDate)
                        .font(.system(size: 11.0, weight: .regular))
                    Spacer()
                    Text(viewModel.endDate)
                        .font(.system(size: 11.0, weight: .regular))
                }
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
            ForEach(viewModel.steps) { step in
                HStack {
                    Image(systemName: "calendar")
                    Text(step.friendlyDate)
                    Spacer()
                    Text("\(step.isAdd ? "+" : "-") \(step.value)")
                }
                .swipeActions {
                    Button("Delete") {
                        viewModel.deleteStepAction(step)
                    }
                    .tint(.red)
                    Button("Edit") {
                        viewModel.editStepAction(step)
                    }
                    .tint(.blue)
                }
            }
        }
    }

}
