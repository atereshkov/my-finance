import SwiftUI

import MyFinanceComponentsKit

public struct WelcomeView<Login: View>: View {

    @ObservedObject var viewModel: WelcomeViewModel

    private var loginViewProvider: () -> Login

    public init(
        viewModel: WelcomeViewModel,
        loginViewProvider: @escaping () -> Login
    ) {
        self.viewModel = viewModel
        self.loginViewProvider = loginViewProvider
    }

    public var body: some View {
        NavigationView {
            ZStack {
                backgroundColor
                GeometryReader { metrics in
                    VStack(alignment: .leading, spacing: metrics.size.height * 0.1) {
                        title.padding([.leading, .trailing], 21)
                        subtitle.padding([.leading, .trailing], 21)
                        startButton.padding([.leading, .trailing], 21)
                    }
                }
            }
        }
    }

    var backgroundColor: some View {
        Color.blue.edgesIgnoringSafeArea(.all)
    }

    var title: some View {
        Text("MyReads")
            .foregroundColor(Color.white)
            .font(.system(size: 48))
            .fontWeight(.semibold)
    }

    var subtitle: some View {
        Text("Subtitle")
            .foregroundColor(Color.white)
            .font(.system(size: 22))
            .fontWeight(.light)
    }

    var startButton: some View {
        NavigationLink(destination:
                        self.loginViewProvider()
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
        ) {
            Text("Start")
        }.buttonStyle(PrimaryButton())

//        Button("Sign In") {
//            viewModel.signInAction()
//        }.buttonStyle(PrimaryButton())
    }

}
