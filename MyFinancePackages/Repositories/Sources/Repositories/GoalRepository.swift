import Combine

import FirebaseFirestore
import MyFinanceDomain

public protocol GoalRepository {
    func getGoal(_ id: String, userId: String) -> Future<GoalDTO, Error>
    func addGoal(_ data: AddGoalDTO, userId: String) -> Future<Void, Error>
    func editGoal(id: String, _ data: EditGoalDTO, userId: String) -> Future<Void, Error>
}

public class FirebaseGoalRepository: GoalRepository {

    private let db = Firestore.firestore()

    public init() {
        
    }

    public func addGoal(_ data: AddGoalDTO, userId: String) -> Future<Void, Error> {
        return Future { [weak self] resolve in
            self?.db
                .collection("user_goals")
                .document(userId)
                .collection("goals")
                .addDocument(data: data.toDictionary()) { error in
                    if let error = error {
                        resolve(.failure(error))
                    } else {
                        resolve(.success(()))
                    }
            }
        }
    }

    public func editGoal(id: String, _ data: EditGoalDTO, userId: String) -> Future<Void, Error> {
        return Future { [weak self] resolve in
            self?.db
                .collection("user_goals")
                .document(userId)
                .collection("goals")
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

    public func getGoal(_ id: String, userId: String) -> Future<GoalDTO, Error> {
        return Future { [weak self] resolve in
            self?.db
                .collection("user_goals")
                .document(userId)
                .collection("goals")
                .document(id)
                .getDocument { document, error in
                    if let error = error {
                        resolve(.failure(error))
                    } else if let doc = document, let data = doc.data() {
                        let dto = GoalDTO(id: doc.documentID, data: data)
                        resolve(.success((dto)))
                    }
                }
        }
    }

}
