import SwiftUI

import MyFinanceComponentsKit
import MyFinanceAssetsKit
import MyFinanceDomain

public struct SavingsTransactionsView<AddTransaction: View>: View {

    @ObservedObject var viewModel: SavingsTransactionsViewModel

    private var addTransactionViewProvider: (_ id: String, _ currency: String?) -> AddTransaction

    public init(
        viewModel: SavingsTransactionsViewModel,
        addTransactionViewProvider: @escaping (_ id: String, _ currency: String?) -> AddTransaction
    ) {
        self.viewModel = viewModel
        self.addTransactionViewProvider = addTransactionViewProvider
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
                .navigationBarTitle(Text(viewModel.title))
                .navigationBarItems(trailing: navBarButtons)
        }
    }

    var modalSheetView: some View {
        switch viewModel.routingState.currentModalSheet {
        case .addTransaction(let id, let currency):
            return AnyView(addTransactionViewProvider(id, currency))
        case .editTransaction(_, _):
            return AnyView(Text("Edit Transaction"))
        case .none:
            return AnyView(Text(""))
        }
    }

    var alertView: Alert {
        switch viewModel.routingState.currentAlert {
        case .confirmDeleteTransaction(let item):
            return confirmDeleteStepAlertView(item)
        case .confirmDeleteAllTransactions(let item):
            return confirmDeleteAllTransactionsAlertView(item)
        case .none:
            return Alert(title: Text(""))
        }
    }

    func confirmDeleteStepAlertView(_ item: SavingsTransactionDVO) -> Alert {
        Alert(
            title: Text("Are you sure you want to delete transaction?"),
            primaryButton: .default(Text("Delete")) {
                Task {
                    await viewModel.deleteTransactionActionConfirmed(item)
                }
            },
            secondaryButton: .cancel(Text("Cancel"))
        )
    }

    func confirmDeleteAllTransactionsAlertView(_ item: SavingsDVO) -> Alert {
        Alert(
            title: Text("Are you sure you want to delete all transactions?"),
            primaryButton: .default(Text("Delete")) {
                Task {
                    await viewModel.deleteAllTransactionsActionConfirmed(item)
                }
            },
            secondaryButton: .cancel(Text("Cancel"))
        )
    }

    var navBarButtons: some View {
        HStack {
            deleteButton
        }
    }

    var deleteButton: some View {
        Button(
            action: viewModel.deleteAllTransactionsAction,
            label: { Image(systemName: "trash").imageScale(.large) }
        )
    }

    var list: some View {
        List {
            detailsSection
            statsSection
            stepsSection
        }
    }

    var addTransactionButton: some View {
        Button(
            action: viewModel.addTransactionAction,
            label: {
                HStack {
                    Image(systemName: "plus").imageScale(.large)
                    Text("Add savings topup")
                }
            }
        )
    }

    var detailsSection: some View {
        Section {
//            VStack(alignment: .leading) {
//                HStack {
//                    Text("Balance: \(viewModel.currentValue)")
//                    Spacer()
//                    MeasureBadgeView(title: viewModel.currency)
//                }
//            }
//            VStack(alignment: .leading) {
//                HStack {
//                    Text(viewModel.startValue)
//                        .font(.system(size: 12.0, weight: .regular))
//                    Spacer()
//                    Text(viewModel.estimatedSum)
//                        .font(.system(size: 12.0, weight: .regular))
//                }
//                GoalProgressView(value: $viewModel.progressValue).frame(height: 20)
//                HStack {
//                    Text(viewModel.startDate)
//                        .font(.system(size: 11.0, weight: .regular))
//                    Spacer()
//                    Text("End date")
//                        .font(.system(size: 11.0, weight: .regular))
//                }
//            }
        }
    }

    var statsSection: some View {
        Section {
            VStack(alignment: .leading) {
                Text("Text 123")
                    .font(.system(size: 13.0, weight: .regular))
            }
        }
    }

    var stepsSection: some View {
        Section {
            HStack {
                Image(systemName: "calendar")
                Text("Top up before ...")
                    .foregroundColor(.gray)
                    .font(.system(size: 13.0, weight: .regular))
            }
            addTransactionButton
            ForEach(viewModel.transactions) { transaction in
                HStack {
                    Image(systemName: "calendar")
                    Text(transaction.date.formatted(date: .numeric, time: .omitted))
                    Spacer()
                    Text("\(transaction.isAdd ? "+" : "-") \(transaction.value.formattedAsCurrency() ?? "")")
                        .foregroundColor(transaction.isAdd ? .green : .orange)
                }
                .swipeActions {
                    Button("Delete") {
                        viewModel.deleteTransactionAction(transaction)
                    }
                    .tint(.red)
                    Button("Edit") {
                        viewModel.editTransactionAction(transaction)
                    }
                    .tint(.blue)
                }
            }
        }
    }

}
