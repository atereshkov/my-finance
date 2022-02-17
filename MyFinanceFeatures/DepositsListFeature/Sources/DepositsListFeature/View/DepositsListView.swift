import SwiftUI

public struct DepositsListView<DepositsDetail: View>: View {

    @ObservedObject var viewModel: DepositsListViewModel

    private var depositsDetailsViewProvider: (_ id: String) -> DepositsDetail

    public init(
        viewModel: DepositsListViewModel,
        depositsDetailsViewProvider: @escaping (_ id: String) -> DepositsDetail
    ) {
        self.viewModel = viewModel
        self.depositsDetailsViewProvider = depositsDetailsViewProvider
    }

    public var body: some View {
        content
    }

}

extension DepositsListView {

    var content: some View {
        NavigationView {
            deposits
            .padding([.leading, .trailing], 18)
            .navigationBarTitle(Text("My Deposits"), displayMode: .inline)
            .navigationBarItems(trailing: buttons)
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

    var deposits: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.deposits) { item in
                    NavigationLink(
                        destination: depositsDetailsView(item),
                        tag: item.id,
                        selection: $viewModel.routingState.depositsDetails
                    ) {
                        DepositsRowView(item: item)
                    }
                }
            }
        }
    }

    func depositsDetailsView(_ item: DepositsViewItem) -> some View {
        return depositsDetailsViewProvider(item.id)
    }

}
