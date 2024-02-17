import XCTest
@testable import MyFinanceDomain

final class MyFinanceDomainTests: XCTestCase {
    func testExample() throws {
        let deposit = DepositDVO(id: "id", name: "name")
        XCTAssertEqual(deposit.id, "id")
        XCTAssertEqual(deposit.name, "name")
    }
}
