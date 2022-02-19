import Firebase
import FirebaseFirestore

public struct FirebaseFramework {
    public init() {
    }

    public func boot() {
        FirebaseApp.configure()
    }
}
