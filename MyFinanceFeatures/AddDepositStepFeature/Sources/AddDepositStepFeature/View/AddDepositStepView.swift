import SwiftUI

public struct AddDepositStepView: View {

    @ObservedObject var viewModel: AddDepositStepViewModel

    public init(viewModel: AddDepositStepViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        content
            .onAppear(perform: viewModel.onAppear)
            .onDisappear(perform: viewModel.onDisappear)
    }

    var content: some View {
        NavigationView {
            Form {
                moneySection
                dateSection
                addButtonSection
            }.navigationBarTitle("Add Step", displayMode: .inline)
        }
    }

    var moneySection: some View {
        Section {
            HStack {
                TextField("Amount",
                          text: Binding(
                            get: { viewModel.amount ?? "" },
                            set: { viewModel.amount = $0 }
                          )
                )
                .keyboardType(.decimalPad)
            }
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
        }
    }

    var addButton: some View {
        Section {
            Button(action: {
                Task {
                    await viewModel.addDepositStepAction()
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
