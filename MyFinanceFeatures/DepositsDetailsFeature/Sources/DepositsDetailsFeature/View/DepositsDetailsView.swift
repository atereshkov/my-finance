import SwiftUI

import MyFinanceComponentsKit
import MyFinanceAssetsKit
import MyFinanceDomain

public struct DepositDetailsView<EditDeposit: View, AddDepositStep: View>: View {

    @ObservedObject var viewModel: DepositDetailsViewModel

    private var editDepositViewProvider: (_ id: String) -> EditDeposit
    private var addDepositStepViewProvider: (_ id: String) -> AddDepositStep

    public init(
        viewModel: DepositDetailsViewModel,
        editDepositViewProvider: @escaping (_ id: String) -> EditDeposit,
        addDepositStepViewProvider: @escaping (_ id: String) -> AddDepositStep
    ) {
        self.viewModel = viewModel
        self.editDepositViewProvider = editDepositViewProvider
        self.addDepositStepViewProvider = addDepositStepViewProvider
    }

    public var body: some View {
        content
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
                .navigationBarTitle(Text(viewModel.depositName))
                .navigationBarItems(trailing: navBarButtons)
        }
    }

    var modalSheetView: some View {
        switch viewModel.routingState.currentModalSheet {
        case .editDeposit(let id):
            return AnyView(editDepositViewProvider(id))
        case .addDepositStep(let id):
            return AnyView(addDepositStepViewProvider(id))
        case .editDepositStep(_, _):
            return AnyView(Text(""))
        case .none:
            return AnyView(Text(""))
        }
    }

    var alertView: Alert {
        switch viewModel.routingState.currentAlert {
        case .confirmDeleteStep(let item):
            return confirmDeleteStepAlertView(item)
        case .none:
            return Alert(title: Text(""))
        }
    }

    func confirmDeleteStepAlertView(_ item: DepositStepDVO) -> Alert {
        Alert(
            title: Text("Are you sure you want do delete deposit step?"),
            primaryButton: .default(Text("Delete")) {
                Task {
                    await viewModel.deleteStepActionConfirmed(item)
                }
            },
            secondaryButton: .cancel(Text("Cancel"))
        )
    }

    var navBarButtons: some View {
        HStack {
            editButton
        }
    }

    var editButton: some View {
        Button(
            action: viewModel.editDepositAction,
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

    var addDepositStepButton: some View {
        Button(
            action: viewModel.addDepositStepAction,
            label: {
                HStack {
                    Image(systemName: "plus").imageScale(.large)
                    Text("Add deposit step")
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
            addDepositStepButton
            ForEach(viewModel.steps) { step in
                HStack {
                    Image(systemName: "calendar")
                    Text(step.date.formatted(date: .numeric, time: .omitted))
                    Spacer()
                    Text("\(step.isAdd ? "+" : "-") \(step.value.formatted())")
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
