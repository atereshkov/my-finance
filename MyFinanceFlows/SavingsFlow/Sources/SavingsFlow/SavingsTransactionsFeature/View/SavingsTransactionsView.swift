import SwiftUI
import Charts

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
            editButton
            deleteButton
        }
    }

    var editButton: some View {
        Button(
            action: viewModel.editAction,
            label: { Image(systemName: "pencil.circle").imageScale(.large) }
        )
    }

    var deleteButton: some View {
        Button(
            action: viewModel.deleteAllTransactionsAction,
            label: { Image(systemName: "trash").imageScale(.large) }
        )
    }

    var list: some View {
        List {
            if !viewModel.transactions.isEmpty {
                chartSection
            }
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
                    Text("Add transaction")
                }
            }
        )
    }

    var chartSection: some View {
        Section {
            Chart {
                ForEach(viewModel.transactions, id: \.id) { item in
                    LineMark(
                        x: .value("Month", item.date),
                        y: .value("Value", item.isAdd ? item.value : -item.value)
                    )
                }
            }
            .frame(height: 250)
        }
    }

    var statsSection: some View {
        Section {
            VStack(alignment: .leading) {
                Text("Average transaction: 150$")
                    .font(.system(size: 13.0, weight: .regular))
                Text("Average transaction / month: 100$")
                    .font(.system(size: 13.0, weight: .regular))
            }
        }
    }

    var stepsSection: some View {
        Section {
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
