import SwiftUI

import MyFinanceComponentsKit

public struct LoginView<Registration: View>: View {

    @ObservedObject var viewModel: LoginViewModel

    private var registrationViewProvider: () -> Registration

    public init(viewModel: LoginViewModel,
        registrationViewProvider: @escaping () -> Registration
    ) {
        self.viewModel = viewModel
        self.registrationViewProvider = registrationViewProvider
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
            signInButton
                .padding([.leading, .trailing], 21)
                .padding([.top], 18)
            dontHaveAccountLabel.padding()
        }
    }

    var loadingIndicator: some View {
        GeometryReader { metrics in
            CircleLoadingView(color: Color.white)
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

    var signInButton: some View {
        Button("Sign In") {
            viewModel.signInAction()
        }.buttonStyle(PrimaryButton())
    }

    var dontHaveAccountLabel: some View {
        NavigationLink(destination:
                        self.registrationViewProvider()
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
        ) {
            Text("I don't have an account")
                .foregroundColor(Color.white)
                .underline()
        }
    }

    var backgroundColor: some View {
        Color(.black).edgesIgnoringSafeArea(.all)
    }

}
