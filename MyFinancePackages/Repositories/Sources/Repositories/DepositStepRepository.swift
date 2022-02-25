import Combine

import FirebaseFirestore
import MyFinanceDomain

public protocol DepositStepRepository {
    func getDepositSteps(_ depositId: String, userId: String) async throws -> [DepositStepDTO]
    func addDepositStep(_ data: AddDepositStepDTO, depositId: String, userId: String) async throws
    func editDepositStep(id: String, _ data: EditDepositStepDTO, depositId: String, userId: String) async throws
    func deleteDepositStep(id: String, depositId: String, userId: String) async throws
}

public class FirebaseDepositStepRepository: DepositStepRepository {

    private let db = Firestore.firestore()

    public init() {

    }

    public func getDepositSteps(_ depositId: String, userId: String) async throws -> [DepositStepDTO] {
        let snapshot = try await db
            .collection("user_deposits")
            .document(userId)
            .collection("deposits")
            .document(depositId)
            .collection("steps")
            .getDocuments()
        let steps = snapshot.documents
            .compactMap { DepositStepDTO(id: $0.documentID, data: $0.data()) }
        return steps
    }

    public func addDepositStep(_ data: AddDepositStepDTO, depositId: String, userId: String) async throws {
        await db
            .collection("user_deposits")
            .document(userId)
            .collection("deposits")
            .document(depositId)
            .collection("steps")
            .addDocument(data: data.toDictionary())
    }

    public func editDepositStep(id: String, _ data: EditDepositStepDTO, depositId: String, userId: String) async throws {
        try await db
            .collection("user_deposits")
            .document(userId)
            .collection("deposits")
            .document(depositId)
            .collection("steps")
            .document(id)
            .updateData(data.toDictionary())
    }

    public func deleteDepositStep(id: String, depositId: String, userId: String) async throws {
        try await db
            .collection("user_deposits")
            .document(userId)
            .collection("deposits")
            .document(depositId)
            .collection("steps")
            .document(id)
            .delete()
    }

}
