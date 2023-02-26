import Combine

import FirebaseFirestore
import MyFinanceDomain

public protocol SavingsTransactionsRepository {
    func getTransactions(_ savingsId: String, currency: String, userId: String) async throws -> [SavingsTransactionDTO]
    func addTransaction(_ data: AddSavingsTransactionDTO, savingsId: String, userId: String) async throws
    func editTransaction(id: String, _ data: EditSavingsTransactionDTO, savingsId: String, userId: String) async throws
    func deleteTransaction(id: String, savingsId: String, currency: String, userId: String) async throws
}

public class FirebaseSavingsTransactionRepository: SavingsTransactionsRepository {

    private let db = Firestore.firestore()

    public init() {
        
    }

    public func getTransactions(_ savingsId: String, currency: String, userId: String) async throws -> [SavingsTransactionDTO] {
        let snapshot = try await db
            .collection("user_savings")
            .document(userId)
            .collection("savings")
            .document(savingsId)
            .collection("transactions_\(currency)")
            .getDocuments()
        let steps = snapshot.documents
            .compactMap { SavingsTransactionDTO(id: $0.documentID, data: $0.data()) }
        return steps
    }

    public func addTransaction(_ data: AddSavingsTransactionDTO, savingsId: String, userId: String) async throws {
        await db
            .collection("user_savings")
            .document(userId)
            .collection("savings")
            .document(savingsId)
            .collection("transactions_\(data.currency)")
            .addDocument(data: data.toDictionary())
    }

    public func editTransaction(id: String, _ data: EditSavingsTransactionDTO, savingsId: String, userId: String) async throws {
        try await db
            .collection("user_savings")
            .document(userId)
            .collection("savings")
            .document(savingsId)
            .collection("transactions_\(data.currency)")
            .document(id)
            .updateData(data.toDictionary())
    }

    public func deleteTransaction(id: String, savingsId: String, currency: String, userId: String) async throws {
        try await db
            .collection("user_savings")
            .document(userId)
            .collection("savings")
            .document(savingsId)
            .collection("transactions_\(currency)")
            .document(id)
            .delete()
    }

}
