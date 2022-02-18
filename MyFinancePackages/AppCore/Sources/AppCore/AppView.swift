import SwiftUI

import AppState

import RootFeature
import WelcomeFeature
import LoginFeature
import RegistrationFeature
import TabBarFeature
import SavingsListFeature
import SavingsDetailsFeature
import DepositsListFeature
import DepositsDetailsFeature
import GoalsListFeature
import GoalDetailsFeature
import AddGoalFeature
import EditGoalFeature
import AddGoalStepFeature

public struct AppView: View {

    private let appState: Store<AppState>

    public init(appState: Store<AppState>) {
        self.appState = appState
    }

    public var body: some View {
        RootView(
            viewModel: RootViewModel(appState: appState),
            welcomeViewProvider: { welcomeView },
            tabBarViewProvider: { tabBarView }
        )
    }

    var welcomeView: some View {
        WelcomeView(
            viewModel: WelcomeViewModel(appState: appState),
            loginViewProvider: { loginView }
        )
    }

    var loginView: some View {
        LoginView(
            viewModel: LoginViewModel(
                dataService: LoginDataService(),
                onAuth: {
                    appState[\.auth.isAuthorized] = true
                }
            ),
            registrationViewProvider: { registrationView }
        )
    }

    var registrationView: some View {
        RegistrationView(viewModel: RegistrationViewModel())
    }

    var tabBarView: some View {
        TabBarView(providers: [
            homeTabProvider,
            savingsTabProvider,
            depositsTabProvider,
            investmentsTabProvider,
            goalsTabProvider
        ])
    }

    var homeTabProvider: TabViewProvider {
        return TabViewProvider(
            systemImageName: "house.fill",
            tabName: "Home"
        ) {
            return AnyView(Text("Home").padding())
        }
    }

    var savingsTabProvider: TabViewProvider {
        return TabViewProvider(
            systemImageName: "dollarsign.circle.fill",
            tabName: "Savings"
        ) {
            return AnyView(SavingsListView(
                viewModel: SavingsListViewModel(),
                savingsDetailViewProvider: { id in savingsDetail(id: id) }
            ))
        }
    }

    func savingsDetail(id: String) -> some View {
        SavingsDetailsView(id: id)
    }

    var depositsTabProvider: TabViewProvider {
        return TabViewProvider(
            systemImageName: "building.columns.fill",
            tabName: "Deposits"
        ) {
            return AnyView(DepositsListView(
                viewModel: DepositsListViewModel(),
                depositsDetailsViewProvider: { id in depositsDetails(id: id) }
            ))
        }
    }

    func depositsDetails(id: String) -> some View {
        DepositsDetailsView(id: id)
    }

    var investmentsTabProvider: TabViewProvider {
        return TabViewProvider(
            systemImageName: "waveform.circle.fill",
            tabName: "Investments"
        ) {
            return AnyView(Text("Investments").padding())
        }
    }

    var goalsTabProvider: TabViewProvider {
        return TabViewProvider(
            systemImageName: "target",
            tabName: "Goals"
        ) {
            return AnyView(GoalsListView(
                viewModel: GoalsListViewModel(),
                goalDetailsViewProvider: { id in goalDetails(id: id) },
                addGoalViewProvider: { addGoalView() }
            ))
        }
    }

    func addGoalView() -> some View {
        AddGoalView(viewModel: AddGoalViewModel())
    }

    func goalDetails(id: String) -> some View {
        GoalDetailsView(
            viewModel: GoalDetailsViewModel(id: id),
            editGoalViewProvider: { id in editGoal(id: id) },
            addGoalStepViewProvider: { AddGoalStepView(viewModel: AddGoalStepViewModel()) }
        )
    }

    func editGoal(id: String) -> some View {
        EditGoalView(viewModel: EditGoalViewModel(id: id))
    }

}
