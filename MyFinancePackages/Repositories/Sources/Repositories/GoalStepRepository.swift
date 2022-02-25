import Combine

import FirebaseFirestore
import MyFinanceDomain

public protocol GoalStepRepository {
    func getGoalSteps(_ goalId: String, userId: String) async throws -> [GoalStepDTO]
    func addGoalStep(_ data: AddGoalStepDTO, goalId: String, userId: String) async throws
    func editGoalStep(id: String, _ data: EditGoalStepDTO, goalId: String, userId: String) async throws
    func deleteGoalStep(id: String, goalId: String, userId: String) async throws
}

public class FirebaseGoalStepRepository: GoalStepRepository {

    private let db = Firestore.firestore()

    public init() {
        
    }

    public func getGoalSteps(_ goalId: String, userId: String) async throws -> [GoalStepDTO] {
        let snapshot = try await db
            .collection("user_goals")
            .document(userId)
            .collection("goals")
            .document(goalId)
            .collection("steps")
            .getDocuments()
        let steps = snapshot.documents
            .compactMap { GoalStepDTO(id: $0.documentID, data: $0.data()) }
        return steps
    }

    public func addGoalStep(_ data: AddGoalStepDTO, goalId: String, userId: String) async throws {
        await db
            .collection("user_goals")
            .document(userId)
            .collection("goals")
            .document(goalId)
            .collection("steps")
            .addDocument(data: data.toDictionary())
    }

    public func editGoalStep(id: String, _ data: EditGoalStepDTO, goalId: String, userId: String) async throws {
        try await db
            .collection("user_goals")
            .document(userId)
            .collection("goals")
            .document(goalId)
            .collection("steps")
            .document(id)
            .updateData(data.toDictionary())
    }

    public func deleteGoalStep(id: String, goalId: String, userId: String) async throws {
        try await db
            .collection("user_goals")
            .document(userId)
            .collection("goals")
            .document(goalId)
            .collection("steps")
            .document(id)
            .delete()
    }

}
