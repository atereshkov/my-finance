import Combine

import FirebaseFirestore

public protocol GoalRepository {
    func addGoal() -> Future<Void, Error>
}

public class FirebaseGoalRepository: GoalRepository {

    public func addGoal() -> Future<Void, Error> {
        return Future { resolve in
            resolve(.success(()))
        }
    }

}
