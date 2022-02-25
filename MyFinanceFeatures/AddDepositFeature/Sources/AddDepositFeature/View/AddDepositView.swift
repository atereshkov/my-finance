import SwiftUI

public struct AddDepositView: View {

    @ObservedObject var viewModel: AddDepositViewModel

    @Environment(\.dismiss) var dismiss

    public init(viewModel: AddDepositViewModel) {
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
            }.navigationBarTitle(viewModel.title ?? "", displayMode: .inline)
        }
    }

    var moneySection: some View {
        Section {
            HStack {
                TextField("Name", text: Binding(
                            get: { viewModel.name ?? "" },
                            set: { viewModel.name = $0 }))
            }
            HStack {
                Text("Currency")
                    .foregroundColor(Color.gray)
                Spacer()
                Picker(viewModel.currencyOptions[viewModel.currencyIndex].name, selection: $viewModel.currencyIndex) {
                    ForEach(0..<viewModel.currencyOptions.count) { index in
                        Text(viewModel.currencyOptions[index].name).tag(index)
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }
            HStack {
                TextField("Goal", text: Binding(
                            get: { viewModel.goal ?? "" },
                            set: { viewModel.goal = $0 })
                )
                .keyboardType(.decimalPad)
            }
            HStack {
                TextField("Start", text: Binding(
                            get: { viewModel.start ?? "" },
                            set: { viewModel.start = $0 })
                )
                .keyboardType(.decimalPad)
            }
            HStack {
                TextField("Current", text: Binding(
                            get: { viewModel.current ?? "" },
                            set: { viewModel.current = $0 })
                )
                .keyboardType(.decimalPad)
            }
        }
    }

    var dateSection: some View {
        Section {
            DatePicker("Start Date", selection: $viewModel.startDate, displayedComponents: .date)
                .datePickerStyle(DefaultDatePickerStyle())
                .frame(maxHeight: 400)
            DatePicker("End Date", selection: $viewModel.endDate, displayedComponents: .date)
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
                    await viewModel.addGoalAction()
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
