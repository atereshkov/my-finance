import SwiftUI

public struct AddGoalView: View {

    @ObservedObject var viewModel: AddGoalViewModel

    @State var goalMeasureIndex: Int = 0
    @State var startDate = Date()
    @State var endDate = Date()

    public init(viewModel: AddGoalViewModel) {
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
                Text("Measure")
                    .foregroundColor(Color.gray)
                Spacer()
                Picker(viewModel.goalMeasureOptions[goalMeasureIndex].name, selection: $goalMeasureIndex) {
                    ForEach(0..<viewModel.goalMeasureOptions.count) { index in
                        Text(viewModel.goalMeasureOptions[index].name).tag(index)
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
                TextField("Done", text: Binding(
                            get: { viewModel.done ?? "" },
                            set: { viewModel.done = $0 })
                )
                .keyboardType(.decimalPad)
            }
        }
    }

    var dateSection: some View {
        Section {
            DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                .datePickerStyle(DefaultDatePickerStyle())
                .frame(maxHeight: 400)
            DatePicker("End Date", selection: $endDate, displayedComponents: .date)
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
                viewModel.addGoalAction()
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
