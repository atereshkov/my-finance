import Combine

import FirebaseFirestore
import MyFinanceDomain

public protocol SavingsRepository {
    func getSavings(_ id: String, userId: String) async throws -> SavingsDTO
    func addSavings(_ data: AddSavingsDTO, userId: String) async throws
    func editSavings(id: String, _ data: EditSavingsDTO, userId: String) async throws
    func deleteSavings(id: String, userId: String) async throws

    func updateCurrentValue(id: String, value: Double, isAdd: Bool, userId: String) async throws
}

public class FirebaseSavingsRepository: SavingsRepository {

    private let db = Firestore.firestore()

    public init() {

    }

    public func getSavings(_ id: String, userId: String) async throws -> SavingsDTO {
        let doc = try await db
            .collection("user_savings")
            .document(userId)
            .collection("savings")
            .document(id)
            .getDocument()
        let dto = SavingsDTO(id: doc.documentID, data: doc.data() ?? [:])
        return dto
    }

    public func addSavings(_ data: AddSavingsDTO, userId: String) async throws {
        try await db
            .collection("user_savings")
            .document(userId)
            .collection("savings")
            .addDocument(data: data.toDictionary())
    }

    public func editSavings(id: String, _ data: EditSavingsDTO, userId: String) async throws {
        try await db
            .collection("user_savings")
            .document(userId)
            .collection("savings")
            .document(id)
            .updateData(data.toDictionary())
    }

    public func deleteSavings(id: String, userId: String) async throws {
        try await db
            .collection("user_savings")
            .document(userId)
            .collection("savings")
            .document(id)
            .delete()
    }

    public func updateCurrentValue(id: String, value: Double, isAdd: Bool, userId: String) async throws {
        try await db
            .collection("user_savings")
            .document(userId)
            .collection("savings")
            .document(id)
            .updateData([
                "currentValue": FieldValue.increment(isAdd ? value : -value)
            ])
    }

}
