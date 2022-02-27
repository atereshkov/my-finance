import SwiftUI

import MyFinanceComponentsKit
import MyFinanceAssetsKit
import MyFinanceDomain

public struct DepositsListView<DepositsDetail: View, AddDeposit: View>: View {

    @ObservedObject var viewModel: DepositsListViewModel

    private var depositDetailsViewProvider: (_ id: String) -> DepositsDetail
    private var addDepositViewProvider: () -> AddDeposit

    public init(
        viewModel: DepositsListViewModel,
        depositDetailsViewProvider: @escaping (_ id: String) -> DepositsDetail,
        addDepositViewProvider: @escaping () -> AddDeposit
    ) {
        self.viewModel = viewModel
        self.depositDetailsViewProvider = depositDetailsViewProvider
        self.addDepositViewProvider = addDepositViewProvider
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

extension DepositsListView {

    var content: some View {
        NavigationView {
            ZStack {
                Color.primaryBackground.ignoresSafeArea()
                goals
                    .padding([.leading, .trailing], 18)
                    .navigationBarTitle(Text("My Deposits"), displayMode: .inline)
                    .navigationBarItems(trailing: navBarButtons)
            }
        }
    }

    var modalSheet: some View {
        switch viewModel.routingState.currentModalSheet {
        case .addDeposit:
            return AnyView(addDepositViewProvider())
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
            action: viewModel.addGoalAction,
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
                ForEach(viewModel.deposits) { item in
                    NavigationLink(
                        destination: NavigationLazyView(depositDetailsView(item)),
                        tag: item.id,
                        selection: $viewModel.routingState.depositDetails
                    ) {
                        DepositsRowView(item: item)
                    }
                }
            }
        }
    }

    func depositDetailsView(_ item: DepositDVO) -> some View {
        return depositDetailsViewProvider(item.id)
    }

}
