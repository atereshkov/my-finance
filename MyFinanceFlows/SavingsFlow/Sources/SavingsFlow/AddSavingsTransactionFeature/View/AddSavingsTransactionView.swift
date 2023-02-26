import SwiftUI

public struct AddSavingsTransactionView: View {

    @ObservedObject var viewModel: AddSavingsTransactionViewModel

    @Environment(\.dismiss) var dismiss

    public init(viewModel: AddSavingsTransactionViewModel) {
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
                moneySection
                dateSection
                addButtonSection
            }.navigationBarTitle(viewModel.title, displayMode: .inline)
        }
    }

    var moneySection: some View {
        Section {
            HStack {
                TextField("0", text: Binding(
                    get: { viewModel.value ?? "" },
                    set: { viewModel.value = $0 })
                )
                .keyboardType(.decimalPad)
                Spacer()
                Menu {
                    ForEach(viewModel.currencies) { currency in
                        Button {
                            viewModel.chooseCurrencyDropDownAction(currency)
                        } label: {
                            Text(currency.name)
                            Image(systemName: "arrow.down.right.circle")
                        }
                    }
                } label: {
                    Text(viewModel.currency?.name ?? "Choose")
                    Image(systemName: "tag.circle")
                }
                .disabled(!viewModel.currencyCanBeChanged)
            }
            Toggle("Saving", isOn: $viewModel.isAdd)
        }
    }

    var dateSection: some View {
        Section {
            DatePicker("Date", selection: $viewModel.date, displayedComponents: .date)
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
                    await viewModel.addTransactionAction()
                }
            }, label: {
                HStack {
                    Spacer()
                    Text("Add")
                        .disabled(!viewModel.isValid)
                    Spacer()
                }
            }).disabled(!viewModel.isValid)
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
