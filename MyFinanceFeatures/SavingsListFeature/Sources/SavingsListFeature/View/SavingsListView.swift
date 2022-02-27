import SwiftUI

import MyFinanceComponentsKit
import MyFinanceAssetsKit

public struct SavingsListView<SavingsDetail: View>: View {

    @ObservedObject var viewModel: SavingsListViewModel

    private var savingsDetailViewProvider: (_ id: String) -> SavingsDetail

    public init(
        viewModel: SavingsListViewModel,
        savingsDetailViewProvider: @escaping (_ id: String) -> SavingsDetail
    ) {
        self.viewModel = viewModel
        self.savingsDetailViewProvider = savingsDetailViewProvider
    }

    public var body: some View {
        content
    }

}

extension SavingsListView {

    var content: some View {
        NavigationView {
            ZStack {
                Color.primaryBackground.ignoresSafeArea()
                savings
                        .padding([.leading, .trailing], 18)
                        .navigationBarTitle(Text("My Savings"), displayMode: .inline)
                        .navigationBarItems(trailing: buttons)
            }
        }
    }

    var buttons: some View {
        HStack {
            dashboardButton
            addButton
        }
    }

    var addButton: some View {
        Button(
//            action: viewModel.accountAction,
            action: { },
            label: { Image(systemName: "plus").imageScale(.large) }
        )
    }

    var dashboardButton: some View {
        Button(
//            action: viewModel.accountAction,
            action: { },
            label: { Image(systemName: "arrow.up.right").imageScale(.large) }
        )
    }

    var savings: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.savings) { item in
                    NavigationLink(
                        destination: NavigationLazyView(savingsDetailView(item)),
                        tag: item.id,
                        selection: $viewModel.routingState.savingsDetails
                    ) {
                        SavingsRowView(item: item)
                    }
                }
            }
        }
    }

    func savingsDetailView(_ item: SavingsViewItem) -> some View {
        return savingsDetailViewProvider(item.id)
    }

}
