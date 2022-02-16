import SwiftUI
import Combine

import AppState

public class RootViewModel: ObservableObject {

    @Published var isAuthorized: Bool = true

    private var subscriptions: Set<AnyCancellable> = []

    public init(appState: Store<AppState>) {
        appState.map(\.auth.isAuthorized)
            .removeDuplicates()
            .assign(to: \.isAuthorized, on: self)
            .store(in: &subscriptions)
    }

}
