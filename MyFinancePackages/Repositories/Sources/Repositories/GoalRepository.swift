import Combine

import FirebaseFirestore
import MyFinanceDomain

public protocol GoalRepository {
    func addGoal(_ data: GoalDTO, userId: String) -> Future<Void, Error>
}

public class FirebaseGoalRepository: GoalRepository {

    private let db = Firestore.firestore()

    public init() {
        
    }

    public func addGoal(_ data: GoalDTO, userId: String) -> Future<Void, Error> {
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

}
