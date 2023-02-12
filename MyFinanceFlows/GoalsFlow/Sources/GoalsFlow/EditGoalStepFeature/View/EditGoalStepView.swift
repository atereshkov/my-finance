import SwiftUI

public struct EditGoalStepView: View {

    @ObservedObject var viewModel: EditGoalStepViewModel

    public init(viewModel: EditGoalStepViewModel) {
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
                saveButtonSection
            }.navigationBarTitle("Edit Step", displayMode: .inline)
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
            Toggle("Top-up", isOn: $viewModel.isAdd)
        }
    }

    var dateSection: some View {
        Section {
            DatePicker("Date", selection: $viewModel.date, displayedComponents: .date)
                .datePickerStyle(DefaultDatePickerStyle())
                .frame(maxHeight: 400)
        }
    }

    var saveButtonSection: some View {
        switch viewModel.state {
        case .start:
            return AnyView(saveButton)
        case .loading:
            return AnyView(loadingView)
        }
    }

    var saveButton: some View {
        Section {
            Button(action: {
                Task {
                    await viewModel.editGoalStepAction()
                }
            }, label: {
                HStack {
                    Spacer()
                    Text("Save")
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
