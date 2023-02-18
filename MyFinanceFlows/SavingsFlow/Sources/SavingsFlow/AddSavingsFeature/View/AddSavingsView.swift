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
                Picker(viewModel.savingsMeasureOptions[viewModel.savingsMeasureIndex].name, selection: $viewModel.savingsMeasureIndex) {
                    ForEach(0..<viewModel.savingsMeasureOptions.count, id: \.self) { index in
                        Text(viewModel.savingsMeasureOptions[index].name).tag(index)
                    }
                }
                .pickerStyle(MenuPickerStyle())
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
