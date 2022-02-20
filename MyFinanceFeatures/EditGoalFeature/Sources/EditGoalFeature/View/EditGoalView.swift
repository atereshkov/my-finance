import SwiftUI

public struct EditGoalView: View {

    @ObservedObject var viewModel: EditGoalViewModel

    public init(viewModel: EditGoalViewModel) {
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
            }.navigationBarTitle("Edit Goal", displayMode: .inline)
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
                Text("Measure")
                    .foregroundColor(Color.gray)
                Spacer()
                Picker(viewModel.goalMeasureOptions[viewModel.goalMeasureIndex].name, selection: $viewModel.goalMeasureIndex) {
                    ForEach(0..<viewModel.goalMeasureOptions.count) { index in
                        Text(viewModel.goalMeasureOptions[index].name).tag(index)
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }
            HStack {
                TextField("Goal", text: Binding(
                            get: { viewModel.goalValue ?? "" },
                            set: { viewModel.goalValue = $0 })
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
                .disabled(true)
                .foregroundColor(Color.gray.opacity(0.5))
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
        }
    }

    var addButton: some View {
        Section {
            Button(action: {
                viewModel.editGoalAction()
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
