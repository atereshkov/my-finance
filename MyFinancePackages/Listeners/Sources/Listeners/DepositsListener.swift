import Combine

import AppState

import FirebaseFirestore
import MyFinanceDomain

public protocol DepositsListenerType: Listener {

}

public class DepositsListener: DepositsListenerType {

    private var cancellables: Set<AnyCancellable> = []

    private var listener: ListenerRegistration?
    private let db = Firestore.firestore()

    private let appState: Store<AppState>

    public init(appState: Store<AppState>) {
        self.appState = appState
    }

    public func start() {
        appState.map(\.user.id)
            .removeDuplicates()
            .sink { [weak self] id in
                guard let id = id else { return }
                self?.listenDeposits(userId: id)
            }
            .store(in: &cancellables)
    }

    public func stop() {
        listener?.remove()
        listener = nil
    }

}

private extension DepositsListener {

    private func listenDeposits(userId: String) {
        listener = db.collection("user_deposits")
            .document(userId)
            .collection("deposits")
            .addSnapshotListener { [weak self] querySnapshot, error in
                if let error = error {
                    Swift.print(error)
                } else if let documents = querySnapshot?.documents {
                    let goals = documents
                        .map { DepositDVO(id: $0.documentID, data: $0.data()) }
                    self?.appState[\.data.deposits] = goals
                }
            }
    }

}
