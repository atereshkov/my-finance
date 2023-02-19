import SwiftUI

import MyFinanceComponentsKit
import MyFinanceAssetsKit
import MyFinanceDomain

public struct SavingsDetailsView<EditSavings: View,
                                 AddSavingsStep: View>: View {

    @ObservedObject var viewModel: SavingsDetailsViewModel

    private var editSavingsViewProvider: (_ id: String) -> EditSavings
    private var addSavingsStepViewProvider: (_ id: String) -> AddSavingsStep

    public init(
        viewModel: SavingsDetailsViewModel,
        editSavingsViewProvider: @escaping (_ id: String) -> EditSavings,
        addSavingsStepViewProvider: @escaping (_ id: String) -> AddSavingsStep
    ) {
        self.viewModel = viewModel
        self.editSavingsViewProvider = editSavingsViewProvider
        self.addSavingsStepViewProvider = addSavingsStepViewProvider
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
        case .addSavingsStep(let id):
            return AnyView(addSavingsStepViewProvider(id))
        case .editSavingsStep(_, _):
            return AnyView(Text(""))
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
            detailsSection
            statsSection
            stepsSection
        }
    }

    var detailsSection: some View {
        Section {
            VStack(alignment: .leading) {
                HStack {
//                    Text("Balance: \(viewModel.currentValue)")
//                    Spacer()
//                    MeasureBadgeView(title: viewModel.currency)
                }
            }
            VStack(alignment: .leading) {
                HStack {
                    Text("viewModel.startValue")
                        .font(.system(size: 12.0, weight: .regular))
                    Spacer()
                    Text(viewModel.estimatedSum)
                        .font(.system(size: 12.0, weight: .regular))
                }
                GoalProgressView(value: $viewModel.progressValue).frame(height: 20)
                HStack {
                    Text(viewModel.startDate)
                        .font(.system(size: 11.0, weight: .regular))
                    Spacer()
                    Text("End date")
                        .font(.system(size: 11.0, weight: .regular))
                }
            }
        }
    }

    var statsSection: some View {
        Section {
            VStack(alignment: .leading) {
                Text("Some text")
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
            ForEach(viewModel.currencies) { currency in
                NavigationLink(value: NavigationDestination(id: currency.currency, parentId: viewModel.id, type: .savingsTransactions)) {
                    HStack {
                        Image(systemName: "calendar")
                        Text(currency.currency)
                        Spacer()
                        Text(currency.value.formattedAsCurrency() ?? "")
                    }
                }
//                .navigationDestination(for: NavigationDestination.self) { destination in
//                    NavigationLazyView(savingsTransactionsViewProvider(destination.id))
//                }
            }
        }
    }

}
