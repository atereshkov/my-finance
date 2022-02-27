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
                infoSection
                moneySection
                dateSection
                addButtonSection
            }.navigationBarTitle(viewModel.title ?? "", displayMode: .inline)
        }
    }

    var infoSection: some View {
        Section {
            HStack {
                TextField("Bank Name", text: Binding(
                            get: { viewModel.bankName ?? "" },
                            set: { viewModel.bankName = $0 }))
            }
            HStack {
                TextField("Deposit Name", text: Binding(
                            get: { viewModel.name ?? "" },
                            set: { viewModel.name = $0 }))
            }
            HStack {
                Toggle("Revocable", isOn: $viewModel.isRevocable)
                    .foregroundColor(Color.gray)
            }
            HStack {
                Toggle("Capitalizable", isOn: $viewModel.isCapitalizable)
                    .foregroundColor(Color.gray)
            }
        }
    }

    var moneySection: some View {
        Section {
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
                TextField("Start Value", text: Binding(
                            get: { viewModel.startValue ?? "" },
                            set: { viewModel.startValue = $0 })
                )
                .keyboardType(.decimalPad)
            }
            HStack {
                TextField("Rate (%)", text: Binding(
                            get: { viewModel.rate ?? "" },
                            set: { viewModel.rate = $0 })
                )
                .keyboardType(.decimalPad)
            }
            HStack {
                TextField("Tax (%)", text: Binding(
                            get: { viewModel.tax ?? "" },
                            set: { viewModel.tax = $0 })
                )
                .keyboardType(.decimalPad)
            }
            HStack {
                Text(viewModel.isCapitalizable ? "Capitalization" : "Payout")
                    .foregroundColor(Color.gray)
                Spacer()
                Picker(
                    viewModel.payoutOptions[viewModel.payoutIndex]?.localized() ?? "",
                    selection: $viewModel.payoutIndex
                ) {
                    ForEach(0..<viewModel.payoutOptions.count) { index in
                        Text(
                            viewModel.payoutOptions[index]?.localized() ?? ""
                        ).tag(index)
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }
            if viewModel.isCustomCapitalizationPeriod {
                HStack {
                    TextField("Period (days)", text: Binding(
                                get: { viewModel.customPeriodDays ?? "" },
                                set: { viewModel.customPeriodDays = $0 })
                    )
                    .keyboardType(.decimalPad)
                }
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
            DatePicker("Top Up End Date", selection: $viewModel.topUpEndDate, displayedComponents: .date)
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
                    await viewModel.addDepositAction()
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
