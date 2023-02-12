import SwiftUI

import MyFinanceComponentsKit
import MyFinanceAssetsKit
import MyFinanceDomain

public struct GoalDetailsView<EditGoal: View, AddGoalStep: View, EditGoalStep: View>: View {

    @ObservedObject var viewModel: GoalDetailsViewModel

    private var editGoalViewProvider: (_ id: String) -> EditGoal
    private var addGoalStepViewProvider: (_ id: String) -> AddGoalStep
    private var editGoalStepViewProvider: (_ step: GoalStepDVO, _ goalId: String) -> EditGoalStep

    public init(
        viewModel: GoalDetailsViewModel,
        editGoalViewProvider: @escaping (_ id: String) -> EditGoal,
        addGoalStepViewProvider: @escaping (_ id: String) -> AddGoalStep,
        editGoalStepViewProvider: @escaping (_ step: GoalStepDVO, _ goalId: String) -> EditGoalStep
    ) {
        self.viewModel = viewModel
        self.editGoalViewProvider = editGoalViewProvider
        self.addGoalStepViewProvider = addGoalStepViewProvider
        self.editGoalStepViewProvider = editGoalStepViewProvider
    }

    public var body: some View {
        content
            .onAppear(perform: viewModel.onAppear)
            .alert(isPresented: $viewModel.routingState.showAlert) {
                alertView
            }
            .sheet(
                isPresented: $viewModel.routingState.showModalSheet,
                content: {
                    modalSheetView
                })
    }

    var content: some View {
        ZStack {
            Color.primaryBackground.ignoresSafeArea()
            list
                .navigationBarTitle(Text(viewModel.goalName))
                .navigationBarItems(trailing: navBarButtons)
        }
    }

    var modalSheetView: some View {
        switch viewModel.routingState.currentModalSheet {
        case .editGoal(let id):
            return AnyView(editGoalViewProvider(id))
        case .addGoalStep(let id):
            return AnyView(addGoalStepViewProvider(id))
        case .editGoalStep(let step, let goalId):
            return AnyView(editGoalStepViewProvider(step, goalId))
        case .none:
            return AnyView(Text(""))
        }
    }

    var alertView: Alert {
        switch viewModel.routingState.currentAlert {
        case .confirmDeleteStep(let item):
            return confirmDeleteStepAlertView(item)
        case .confirmDeleteGoal(let item):
            return confirmDeleteGoalAlertView(item)
        case .none:
            return Alert(title: Text(""))
        }
    }

    func confirmDeleteStepAlertView(_ item: GoalStepDVO) -> Alert {
        Alert(
            title: Text("Are you sure you want do delete goal step?"),
            primaryButton: .default(Text("Delete")) {
                Task {
                    await viewModel.deleteStepActionConfirmed(item)
                }
            },
            secondaryButton: .cancel(Text("Cancel"))
        )
    }

    func confirmDeleteGoalAlertView(_ item: GoalDVO) -> Alert {
        Alert(
            title: Text("Are you sure you want do delete your goal?"),
            primaryButton: .default(Text("Delete")) {
                Task {
                    await viewModel.deleteGoalActionConfirmed(item)
                }
            },
            secondaryButton: .cancel(Text("Cancel"))
        )
    }

    var navBarButtons: some View {
        HStack {
            editButton
            deleteButton
        }
    }

    var editButton: some View {
        Button(
            action: viewModel.editGoalAction,
            label: { Image(systemName: "pencil.circle").imageScale(.large) }
        )
    }

    var deleteButton: some View {
        Button(
            action: viewModel.deleteGoalAction,
            label: { Image(systemName: "trash").imageScale(.large) }
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
                Text("Avg per month: \(viewModel.averagePerMonth)")
                    .font(.system(size: 13.0, weight: .regular))
                Text("Top up by \(viewModel.topUpMonthly) monthly to reach the goal")
                    .font(.system(size: 13.0, weight: .regular))
            }
        }
    }

    var stepsSection: some View {
        Section {
            addGoalStepButton
            ForEach(viewModel.steps) { step in
                HStack {
                    Image(systemName: "calendar")
                    Text(step.date.formatted(date: .numeric, time: .omitted))
                    Spacer()
                    Text("\(step.isAdd ? "+" : "-") \(step.value.formattedAsCurrency() ?? "")")
                        .foregroundColor(step.isAdd ? .green : .orange)
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
