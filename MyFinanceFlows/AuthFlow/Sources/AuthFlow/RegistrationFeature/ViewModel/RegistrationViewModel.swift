import Combine
import SwiftUI

public class RegistrationViewModel: ObservableObject {

    public init() {

    }

    // MARK: - Input

    @Published var email: String?
    @Published var password: String?
    @Published var confirmPassword: String?

    // MARK: - Output

    @Published var state: RegistrationViewState = .start
    @Published var routingState = RegistrationRouting()

}

extension RegistrationViewModel {

    func signUpAction() {
//        guard let email = email?.trim(), let pw = password?.trim() else { return }
//        guard !email.isEmpty, !pw.isEmpty else { return }
//
//        state = .loading
//
//        authService
//            .createUser(email: email, password: pw)
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { [weak self] completion in
//                switch completion {
//                case .failure(let error):
//                    self?.state = .signUpFailed(error: error.localizedDescription)
//                    self?.routingState.showErrorAlert = true
//                case .finished:
//                    break
//                }
//            }, receiveValue: { _ in })
//            .store(in: cancelBag)
    }

    func haveAccountAction() {

    }

}
