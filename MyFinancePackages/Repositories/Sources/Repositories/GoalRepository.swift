import Combine

import FirebaseFirestore
import MyFinanceDomain

public protocol GoalRepository {
    func getGoal(_ id: String, userId: String) async throws -> GoalDTO
    func addGoal(_ data: AddGoalDTO, userId: String) async throws
    func editGoal(id: String, _ data: EditGoalDTO, userId: String) async throws
    func deleteGoal(id: String, userId: String) async throws

    func updateCurrentValue(id: String, value: Double, isAdd: Bool, userId: String) async throws
}

public class FirebaseGoalRepository: GoalRepository {

    private let db = Firestore.firestore()

    public init() {
        
    }

    public func getGoal(_ id: String, userId: String) async throws -> GoalDTO {
        let doc = try await db
            .collection("user_goals")
            .document(userId)
            .collection("goals")
            .document(id)
            .getDocument()
        let dto = GoalDTO(id: doc.documentID, data: doc.data() ?? [:])
        return dto
    }

    public func addGoal(_ data: AddGoalDTO, userId: String) async throws {
        try await db
            .collection("user_goals")
            .document(userId)
            .collection("goals")
            .addDocument(data: data.toDictionary())
    }

    public func editGoal(id: String, _ data: EditGoalDTO, userId: String) async throws {
        try await db
            .collection("user_goals")
            .document(userId)
            .collection("goals")
            .document(id)
            .updateData(data.toDictionary())
    }

    public func deleteGoal(id: String, userId: String) async throws {
        try await db
            .collection("user_goals")
            .document(userId)
            .collection("goals")
            .document(id)
            .delete()
    }

    public func updateCurrentValue(id: String, value: Double, isAdd: Bool, userId: String) async throws {
        try await db
            .collection("user_goals")
            .document(userId)
            .collection("goals")
            .document(id)
            .updateData([
                "currentValue": FieldValue.increment(isAdd ? value : -value)
            ])
    }

}
