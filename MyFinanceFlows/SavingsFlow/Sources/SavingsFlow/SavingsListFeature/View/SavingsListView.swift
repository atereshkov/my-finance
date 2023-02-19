import SwiftUI

import MyFinanceAssetsKit
import MyFinanceComponentsKit
import MyFinanceDomain

public struct SavingsListView<SavingsDetail: View,
                              AddSavings: View,
                              SavingsTransactions: View>: View {

    @ObservedObject var viewModel: SavingsListViewModel

    private var savingsDetailViewProvider: (_ id: String) -> SavingsDetail
    private var savingsTransactionsViewProvider: (_ id: String, _ parentId: String) -> SavingsTransactions
    private var addSavingsViewProvider: () -> AddSavings

    public init(
        viewModel: SavingsListViewModel,
        savingsDetailViewProvider: @escaping (_ id: String) -> SavingsDetail,
        savingsTransactionsViewProvider: @escaping (_ id: String, _ parentId: String) -> SavingsTransactions,
        addSavingsViewProvider: @escaping () -> AddSavings
    ) {
        self.viewModel = viewModel
        self.savingsDetailViewProvider = savingsDetailViewProvider
        self.savingsTransactionsViewProvider = savingsTransactionsViewProvider
        self.addSavingsViewProvider = addSavingsViewProvider
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

extension SavingsListView {

    var content: some View {
        NavigationStack(path: $viewModel.routingState.path) {
            ZStack {
                Color.primaryBackground.ignoresSafeArea()
                goals
                    .padding([.leading, .trailing], 18)
                    .navigationBarTitle(Text("My Savings"), displayMode: .inline)
                    .navigationBarItems(trailing: navBarButtons)
            }
        }
    }

    var modalSheet: some View {
        switch viewModel.routingState.currentModalSheet {
        case .addSavings:
            return AnyView(addSavingsViewProvider())
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
            action: viewModel.addSavingsAction,
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
                ForEach(viewModel.savings) { item in
                    NavigationLink(value: NavigationDestination(id: item.id, parentId: nil, type: .savingsDetails)) {
                        SavingsRowView(item: item)
                    }
                }
            }
            .navigationDestination(for: NavigationDestination.self) { destination in
                switch destination.type {
                case .savingsDetails:
                    NavigationLazyView(savingsDetailViewProvider(destination.id))
                case .savingsTransactions:
                    if let parentId = destination.parentId {
                        NavigationLazyView(savingsTransactionsViewProvider(destination.id, parentId))
                    } else {
                        NavigationLazyView(EmptyView())
                    }
                }
            }
        }
    }

}
