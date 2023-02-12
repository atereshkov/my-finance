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
        case .confirmDeleteDeposit(let item):
            return confirmDeleteDepositAlertView(item)
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

    func confirmDeleteDepositAlertView(_ item: DepositDVO) -> Alert {
        Alert(
            title: Text("Are you sure you want do delete the deposit?"),
            primaryButton: .default(Text("Delete")) {
                Task {
                    await viewModel.deleteDepositActionConfirmed(item)
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
            action: viewModel.editDepositAction,
            label: { Image(systemName: "pencil.circle").imageScale(.large) }
        )
    }

    var deleteButton: some View {
        Button(
            action: viewModel.deleteDepositAction,
            label: { Image(systemName: "trash").imageScale(.large) }
        )
    }

    var list: some View {
        List {
            detailsSection
            statsSection
            monthlyPayoutSection
            stepsSection
        }
    }

    var addDepositStepButton: some View {
        Button(
            action: viewModel.addDepositStepAction,
            label: {
                HStack {
                    Image(systemName: "plus").imageScale(.large)
                    Text("Add deposit topup")
                }
            }
        )
    }

    var detailsSection: some View {
        Section {
            VStack(alignment: .leading) {
                HStack {
                    Text("Balance: \(viewModel.balance)")
                    Spacer()
                    MeasureBadgeView(title: viewModel.currency)
                }
            }
            VStack(alignment: .leading) {
                HStack {
                    Text(viewModel.startValue)
                        .font(.system(size: 12.0, weight: .regular))
                    Spacer()
                    Text(viewModel.estimatedIncome)
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
                Text("Top up by \(viewModel.topUpMonthly) monthly to reach the goal")
                    .font(.system(size: 13.0, weight: .regular))
            }
        }
    }

    var monthlyPayoutSection: some View {
        Section {
            HStack {
                Image(systemName: "calendar")
                Text("Date")
                Spacer()
                Text("Paid")
                Spacer()
                Text("Tax")
                Spacer()
                Text("Sum")
            }
            ForEach(viewModel.payouts) { item in
                HStack {
                    Text(item.date.formatted(date: .numeric, time: .omitted))
                        .font(.system(size: 12.0, weight: .regular))
                    Spacer()
                    Text(item.paid.formattedAsCurrency() ?? "")
                        .font(.system(size: 12.0, weight: .regular))
                    Spacer()
                    Text(item.tax.formattedAsCurrency() ?? "")
                        .font(.system(size: 12.0, weight: .regular))
                    Spacer()
                    Text(item.sum.formattedAsCurrency() ?? "")
                        .font(.system(size: 12.0, weight: .regular))
                }
            }
        }
    }

    var stepsSection: some View {
        Section {
            HStack {
                Image(systemName: "calendar")
                Text("Top up before \(viewModel.topUpEndDate)")
                    .foregroundColor(.gray)
                    .font(.system(size: 13.0, weight: .regular))
            }
            addDepositStepButton
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
