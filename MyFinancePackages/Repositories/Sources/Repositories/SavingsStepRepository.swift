import Combine

import FirebaseFirestore
import MyFinanceDomain

public protocol SavingsStepRepository {
    func getSavingsSteps(_ savingsId: String, userId: String) async throws -> [SavingsStepDTO]
    func addSavingsStep(_ data: AddSavingsStepDTO, savingsId: String, userId: String) async throws
    func editSavingsStep(id: String, _ data: EditSavingsStepDTO, savingsId: String, userId: String) async throws
    func deleteSavingsStep(id: String, savingsId: String, userId: String) async throws
}

public class FirebaseSavingsStepRepository: SavingsStepRepository {

    private let db = Firestore.firestore()

    public init() {

    }

    public func getSavingsSteps(_ savingsId: String, userId: String) async throws -> [SavingsStepDTO] {
        let snapshot = try await db
            .collection("user_savings")
            .document(userId)
            .collection("savings")
            .document(savingsId)
            .collection("steps")
            .getDocuments()
        let steps = snapshot.documents
            .compactMap { SavingsStepDTO(id: $0.documentID, data: $0.data()) }
        return steps
    }

    public func addSavingsStep(_ data: AddSavingsStepDTO, savingsId: String, userId: String) async throws {
        await db
            .collection("user_savings")
            .document(userId)
            .collection("savings")
            .document(savingsId)
            .collection("steps")
            .addDocument(data: data.toDictionary())
    }

    public func editSavingsStep(id: String, _ data: EditSavingsStepDTO, savingsId: String, userId: String) async throws {
        try await db
            .collection("user_savings")
            .document(userId)
            .collection("savings")
            .document(savingsId)
            .collection("steps")
            .document(id)
            .updateData(data.toDictionary())
    }

    public func deleteSavingsStep(id: String, savingsId: String, userId: String) async throws {
        try await db
            .collection("user_savings")
            .document(userId)
            .collection("savings")
            .document(savingsId)
            .collection("steps")
            .document(id)
            .delete()
    }

}
