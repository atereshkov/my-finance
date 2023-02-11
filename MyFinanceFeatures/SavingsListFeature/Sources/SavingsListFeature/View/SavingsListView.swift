import SwiftUI

import MyFinanceAssetsKit
import MyFinanceComponentsKit
import MyFinanceDomain

public struct SavingsListView<SavingsDetail: View, AddSavings: View>: View {

    @ObservedObject var viewModel: SavingsListViewModel

    private var savingsDetailViewProvider: (_ id: String) -> SavingsDetail
    private var addSavingsViewProvider: () -> AddSavings

    public init(
        viewModel: SavingsListViewModel,
        savingsDetailViewProvider: @escaping (_ id: String) -> SavingsDetail,
        addSavingsViewProvider: @escaping () -> AddSavings
    ) {
        self.viewModel = viewModel
        self.savingsDetailViewProvider = savingsDetailViewProvider
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
        NavigationView {
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
                    NavigationLink(
                        destination: NavigationLazyView(savingsDetailsView(item)),
                        tag: item.id,
                        selection: $viewModel.routingState.savingsDetails
                    ) {
                        SavingsRowView(item: item)
                    }
                }
            }
        }
    }

    func savingsDetailsView(_ item: SavingsDVO) -> some View {
        return savingsDetailViewProvider(item.id)
    }

}
