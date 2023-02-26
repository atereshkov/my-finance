import SwiftUI
import Charts

import MyFinanceComponentsKit
import MyFinanceAssetsKit
import MyFinanceDomain

public struct SavingsDetailsView<EditSavings: View,
                                 AddTransaction: View>: View {

    @ObservedObject var viewModel: SavingsDetailsViewModel

    private var editSavingsViewProvider: (_ id: String) -> EditSavings
    private var addTransactionViewProvider: (_ id: String) -> AddTransaction

    public init(
        viewModel: SavingsDetailsViewModel,
        editSavingsViewProvider: @escaping (_ id: String) -> EditSavings,
        addTransactionViewProvider: @escaping (_ id: String) -> AddTransaction
    ) {
        self.viewModel = viewModel
        self.editSavingsViewProvider = editSavingsViewProvider
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
                .navigationBarTitle(Text(viewModel.savingsName))
                .navigationBarItems(trailing: navBarButtons)
        }
    }

    var modalSheetView: some View {
        switch viewModel.routingState.currentModalSheet {
        case .editSavings(let id):
            return AnyView(editSavingsViewProvider(id))
        case .addTransaction(let id):
            return AnyView(addTransactionViewProvider(id))
        case .none:
            return AnyView(Text(""))
        }
    }

    var alertView: Alert {
        switch viewModel.routingState.currentAlert {
        case .confirmDeleteSavings(let item):
            return confirmDeleteSavingsAlertView(item)
        case .none:
            return Alert(title: Text(""))
        }
    }

    func confirmDeleteSavingsAlertView(_ item: SavingsDVO) -> Alert {
        Alert(
            title: Text("Are you sure you want to delete the savings?"),
            primaryButton: .default(Text("Delete")) {
                Task {
                    await viewModel.deleteSavingsActionConfirmed(item)
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
            action: viewModel.editSavingsAction,
            label: { Image(systemName: "pencil.circle").imageScale(.large) }
        )
    }

    var deleteButton: some View {
        Button(
            action: viewModel.deleteSavingsAction,
            label: { Image(systemName: "trash").imageScale(.large) }
        )
    }

    var list: some View {
        List {
            chartSection
            descriptionSection
            stepsSection
        }
    }

    var chartSection: some View {
        Section {
            Chart {
                ForEach(viewModel.chartData, id: \.currency) { series in
                    ForEach(series.data) { item in
                        LineMark(
                            x: .value("Month", item.date),
                            y: .value("Value", item.value)
                        )
                    }
                    .foregroundStyle(by: .value("Currency", series.currency))
                    .symbol(by: .value("Currency", series.currency))
                }
            }
            .frame(height: 250)
        }
    }

    var descriptionSection: some View {
        Section {
            VStack(alignment: .leading) {
                Text(viewModel.description)
                    .font(.system(size: 13.0, weight: .regular))
                Text("Total top-ups: 2000$")
                    .font(.system(size: 13.0, weight: .regular))
                Text("Total withdrawals: 500$")
                    .font(.system(size: 13.0, weight: .regular))
            }
        }
    }

    var stepsSection: some View {
        Section {
            addTransactionButton
            ForEach(viewModel.currencies) { currency in
                NavigationLink(value: NavigationDestination(id: currency.currency, parentId: viewModel.id, type: .savingsTransactions)) {
                    HStack {
                        Image(systemName: currency.currencyIconName)
                        Text(currency.currency)
                        Spacer()
                        Text(currency.value.formattedAsCurrency() ?? "")
                    }
                }
            }
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

}
