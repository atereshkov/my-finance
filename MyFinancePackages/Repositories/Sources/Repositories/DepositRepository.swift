import Combine

import FirebaseFirestore
import MyFinanceDomain

public protocol DepositRepository {
    func getDeposit(_ id: String, userId: String) async throws -> DepositDTO
    func addDeposit(_ data: AddDepositDTO, userId: String) async throws
    func editDeposit(id: String, _ data: EditDepositDTO, userId: String) async throws
    func deleteDeposit(id: String, userId: String) async throws

    func updateCurrentValue(id: String, value: Double, isAdd: Bool, userId: String) async throws
}

public class FirebaseDepositRepository: DepositRepository {

    private let db = Firestore.firestore()

    public init() {

    }

    public func getDeposit(_ id: String, userId: String) async throws -> DepositDTO {
        let document = try await db
            .collection("user_deposits")
            .document(userId)
            .collection("deposits")
            .document(id)
            .getDocument()
        let dto = DepositDTO(id: document.documentID, data: document.data() ?? [:])
        return dto
    }

    public func addDeposit(_ data: AddDepositDTO, userId: String) async throws {
        try await db
            .collection("user_deposits")
            .document(userId)
            .collection("deposits")
            .addDocument(data: data.toDictionary())
    }

    public func editDeposit(id: String, _ data: EditDepositDTO, userId: String) async throws {
        try await db
            .collection("user_deposits")
            .document(userId)
            .collection("deposits")
            .document(id)
            .updateData(data.toDictionary())
    }

    public func deleteDeposit(id: String, userId: String) async throws {
        try await db
            .collection("user_deposits")
            .document(userId)
            .collection("deposits")
            .document(id)
            .delete()
    }

    public func updateCurrentValue(id: String, value: Double, isAdd: Bool, userId: String) async throws {
        try await db
            .collection("user_deposits")
            .document(userId)
            .collection("deposits")
            .document(id)
            .updateData([
                "currentValue": FieldValue.increment(isAdd ? value : -value)
            ])
    }

}
