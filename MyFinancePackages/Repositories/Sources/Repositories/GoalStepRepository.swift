import Combine

import FirebaseFirestore
import MyFinanceDomain

public protocol GoalStepRepository {
    func getGoalSteps(_ goalId: String, userId: String) -> Future<[GoalStepDTO], Error>
    func addGoalStep(_ data: AddGoalStepDTO, goalId: String, userId: String) async throws -> Void
    func editGoalStep(id: String, _ data: EditGoalStepDTO, goalId: String, userId: String) -> Future<Void, Error>
    func deleteGoalStep(id: String, goalId: String, userId: String) -> Future<Void, Error>
}

public class FirebaseGoalStepRepository: GoalStepRepository {

    private let db = Firestore.firestore()

    public init() {
        
    }

    public func getGoalSteps(_ goalId: String, userId: String) -> Future<[GoalStepDTO], Error> {
        return Future { [weak self] resolve in
            self?.db
                .collection("user_goals")
                .document(userId)
                .collection("goals")
                .document(goalId)
                .collection("steps")
                .getDocuments { documentsQuery, error in
                    if let error = error {
                        resolve(.failure(error))
                    } else if let documents = documentsQuery?.documents {
                        let steps = documents
                            .compactMap { GoalStepDTO(id: $0.description, data: $0.data()) }
                        resolve(.success((steps)))
                    }
            }
        }
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

    public func editGoalStep(id: String, _ data: EditGoalStepDTO, goalId: String, userId: String) -> Future<Void, Error> {
        return Future { [weak self] resolve in
            self?.db
                .collection("user_goals")
                .document(userId)
                .collection("goals")
                .document(goalId)
                .collection("steps")
                .document(id)
                .updateData(data.toDictionary()) { error in
                    if let error = error {
                        resolve(.failure(error))
                    } else {
                        resolve(.success(()))
                    }
            }
        }
    }

    public func deleteGoalStep(id: String, goalId: String, userId: String) -> Future<Void, Error> {
        return Future { [weak self] resolve in
            self?.db
                .collection("user_goals")
                .document(userId)
                .collection("goals")
                .document(goalId)
                .collection("steps")
                .document(id)
                .delete { error in
                    if let error = error {
                        resolve(.failure(error))
                    } else {
                        resolve(.success(()))
                    }
            }
        }
    }

}
