import XCTest
@testable import EditGoalFeature

final class EditGoalViewModelTests: XCTestCase {
    func testExample() throws {
        let viewModel = EditGoalViewModel(id: "")
        XCTAssertFalse(viewModel.routingState.isPresented)
        viewModel.onAppear()
        XCTAssertTrue(viewModel.routingState.isPresented)
    }

    func testExample2() throws {
        let viewModel = EditGoalViewModel(id: "")
        viewModel.onDisappear()
        XCTAssertFalse(viewModel.routingState.isPresented)
    }
}
