import SwiftUI

import MyFinanceComponentsKit

public struct RegistrationView: View {

    @ObservedObject var viewModel: RegistrationViewModel

    public init(viewModel: RegistrationViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        NavigationView {
            ZStack {
                backgroundColor
                GeometryReader { metrics in
                    VStack(alignment: .leading) {
                        logo.padding([.leading, .trailing], 21)
                        content.padding(.top, metrics.size.height * 0.07)
                    }
                }
            }
        }
        .alert(isPresented: $viewModel.routingState.showErrorAlert, content: {
            switch viewModel.state {
            case .failed(let error):
                return Alert(title: Text("Error"),
                             message: Text(error),
                             dismissButton: .default(Text("OK")))
            default:
                return Alert(title: Text(""))
            }
        })
    }

    var logo: some View {
        Text("MyReads")
            .foregroundColor(Color.white)
            .font(.system(size: 36))
            .fontWeight(.semibold)
    }

    var content: some View {
        switch viewModel.state {
        case .start:
            return AnyView(form)
        case .loading:
            return AnyView(loadingIndicator)
        case .failed(_):
            return AnyView(form)
        }
    }

    var form: some View {
        VStack {
            emailTextField.padding([.leading, .trailing], 21)
            passwordTextField
                .padding([.leading, .trailing], 21)
                .padding([.top], 18)
            confirmPasswordTextField
                .padding([.leading, .trailing], 21)
                .padding([.top], 18)
            signUpButton
                .padding([.leading, .trailing], 21)
                .padding([.top], 18)
            dontWantToSignUpButton
                .padding([.leading, .trailing], 21)
                .padding([.top], 9)
            alreadyHaveAccountLabel
                .padding()
                .padding([.top], 18)
        }
    }

    var loadingIndicator: some View {
        GeometryReader { metrics in
            CircleLoadingView(color: .white)
                .frame(minWidth: 0, maxWidth: .infinity)
                .frame(height: metrics.size.height * 0.2)
        }
    }

    var emailTextField: some View {
        TextField("", text: Binding(
                    get: { viewModel.email ?? "" },
                    set: { viewModel.email = $0 })
        )
        .textFieldStyle(PrimaryTextField())
        .keyboardType(.emailAddress)
        .disableAutocorrection(true)
        .autocapitalization(.none)
        .placeHolder(Text("E-mail"), show: viewModel.email?.isEmpty ?? true)
    }

    var passwordTextField: some View {
        SecureField("", text: Binding(
                    get: { viewModel.password ?? "" },
                    set: { viewModel.password = $0 })
        )
        .textFieldStyle(PrimaryTextField())
        .disableAutocorrection(true)
        .autocapitalization(.none)
        .placeHolder(Text("Password"), show: viewModel.password?.isEmpty ?? true)
    }

    var confirmPasswordTextField: some View {
        SecureField("", text: Binding(
                    get: { viewModel.confirmPassword ?? "" },
                    set: { viewModel.confirmPassword = $0 })
        )
        .textFieldStyle(PrimaryTextField())
        .disableAutocorrection(true)
        .autocapitalization(.none)
        .placeHolder(Text("Confirm password"), show: viewModel.confirmPassword?.isEmpty ?? true)
    }

    var signUpButton: some View {
        Button("Sign Up") {
            viewModel.signUpAction()
        }.buttonStyle(PrimaryButton())
    }

    var dontWantToSignUpButton: some View {
        Button("I don't want to sign up") {

        }
        .frame(maxWidth: .infinity)
        .padding()
        .foregroundColor(.white)
        .font(.system(size: 16, weight: .semibold))
        .background(Color.clear)
        .shadow(color: Color.black.opacity(0.05), radius: 7, x: 0, y: 6)
        .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.white, lineWidth: 1))
    }

    var alreadyHaveAccountLabel: some View {
        Text("I already have an account")
            .foregroundColor(Color.white)
            .underline()
            .onTapGesture {
                viewModel.haveAccountAction()
            }
    }

    var backgroundColor: some View {
        Color(.black).edgesIgnoringSafeArea(.all)
    }

}
