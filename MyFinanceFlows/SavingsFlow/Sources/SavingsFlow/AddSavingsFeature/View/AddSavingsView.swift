import SwiftUI

public struct AddSavingsView: View {

    @ObservedObject var viewModel: AddSavingsViewModel

    @Environment(\.dismiss) var dismiss

    public init(viewModel: AddSavingsViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        content
            .onAppear(perform: viewModel.onAppear)
            .onDisappear(perform: viewModel.onDisappear)
            .onChange(of: viewModel.state) { state in
                if state == .dismiss {
                    dismiss()
                }
             }
    }

    var content: some View {
        NavigationView {
            Form {
                infoSection
                currenciesSection
                dateSection
                addButtonSection
            }.navigationBarTitle(viewModel.title ?? "", displayMode: .inline)
        }
    }

    var infoSection: some View {
        Section {
            HStack {
                TextField("Name", text: Binding(
                            get: { viewModel.name ?? "" },
                            set: { viewModel.name = $0 }))
            }
            HStack {
                TextField("Description", text: Binding(
                            get: { viewModel.description ?? "" },
                            set: { viewModel.description = $0 }))
            }
        }
    }

    // TODO: Fix '[SwiftUI] Publishing changes from within view updates is not allowed, this will cause undefined behavior.'
    // TODO: Updating currency form drop down doesn't work. Updating value from text field doesn't work.
    var currenciesSection: some View {
        EmptyView()
        /*
        Section {
            HStack {
                Text("Currency")
                    .foregroundColor(Color.gray)
            }
            ForEach(viewModel.currencyFields) { field in
                HStack {
                    TextField("0", text: Binding(
                        get: { String(field.value) },
                        set: { viewModel.updateCurrencyFieldValue(to: Double($0) ?? 0, currency: field) })
                    )
                    Spacer()
                    Menu {
                        ForEach(viewModel.currencies) { currency in
                            Button {
                                viewModel.chooseCurrencyDropDownAction(currency, currency: field)
                            } label: {
                                Text(currency.name)
                                Image(systemName: "arrow.down.right.circle")
                            }
                        }
                    } label: {
                        Text(field.currency)
                        Image(systemName: "tag.circle")
                    }
                }
            }
            HStack {
                Button(
                    action: viewModel.addCurrencyFieldAction,
                    label: {
                        HStack {
                            Spacer()
                            Text("+")
                            Spacer()
                        }
                    }
                )
            }
        }
        */
    }

    var dateSection: some View {
        Section {
            DatePicker("Start Date", selection: $viewModel.startDate, displayedComponents: .date)
                .datePickerStyle(DefaultDatePickerStyle())
                .frame(maxHeight: 400)
        }
    }

    var addButtonSection: some View {
        switch viewModel.state {
        case .start:
            return AnyView(addButton)
        case .loading:
            return AnyView(loadingView)
        case .dismiss:
            return AnyView(EmptyView())
        }
    }

    var addButton: some View {
        Section {
            Button(action: {
                Task {
                    await viewModel.addSavingsAction()
                }
            }, label: {
                HStack {
                    Spacer()
                    Text("Add")
                    Spacer()
                }
            })
        }
    }

    var loadingView: some View {
        Section {
            HStack {
                Spacer()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                Spacer()
            }
        }
    }

}
