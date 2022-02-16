import XCTest
@testable import LoginFeature

final class LoginFeatureTests: XCTestCase {
    func testExample() throws {
        var onAuthCalled: Bool = false
        let viewModel = LoginViewModel(dataService: LoginDataService(), onAuth: {
            onAuthCalled = true
        })
        viewModel.signInAction()
        XCTAssertEqual(onAuthCalled, true)
    }
}
