import SwiftUI

// MARK: Shared

import AppState
import Repositories
import MyFinanceDomain

// MARK: Features

import RootFeature
import WelcomeFeature
import TabBarFeature

// MARK: Flows

import AuthFlow
import DepositsFlow
import GoalsFlow
import SavingsFlow

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
                viewModel: SavingsListViewModel(appState: appState),
                savingsDetailViewProvider: { id in savingsDetail(id: id) },
                savingsTransactionsViewProvider: { id, parentId in savingsTransactions(id: id, parentId: parentId) },
                addSavingsViewProvider: { addSavingsView() }
            ))
        }
    }

    func addSavingsView() -> some View {
        AddSavingsView(viewModel: AddSavingsViewModel(
            appState: appState,
            service: AddSavingsDataService(appState: appState, savingsRepository: FirebaseSavingsRepository()))
        )
    }

    func savingsDetail(id: String) -> some View {
        SavingsDetailsView(
            viewModel: SavingsDetailsViewModel(
                id: id,
                appState: appState,
                dataService: SavingsDataService(
                    appState: appState,
                    savingsRepository: FirebaseSavingsRepository(),
                    transactionsRepository: FirebaseSavingsTransactionRepository()
                )
            ),
            editSavingsViewProvider: { id in editSavings(id: id) },
            addTransactionViewProvider: { id in addTransaction(savingsId: id, currency: nil) }
        )
    }

    func editSavings(id: String) -> some View {
//        EditSavingsView(
//            viewModel: EditSavingsViewModel(
//                id: id,
//                appState: appState,
//                service: EditSavingsDataService(
//                    appState: appState,
//                    depositRepository: FirebaseSavingsRepository()
//                )
//            )
//        )
        return Text("Edit Savings: \(id)")
    }

    func savingsTransactions(id: String, parentId: String) -> some View {
        SavingsTransactionsView(
            viewModel: SavingsTransactionsViewModel(
                id: id,
                parentId: parentId,
                appState: appState,
                dataService: SavingsTransactionsDataService(
                    appState: appState,
                    transactionsRepository: FirebaseSavingsTransactionRepository(),
                    savingsRepository: FirebaseSavingsRepository()
                )
            ),
            addTransactionViewProvider: { id, currency in addTransaction(savingsId: parentId, currency: currency) }
        )
    }

    func addTransaction(savingsId: String, currency: String?) -> some View {
        AddSavingsTransactionView(
            viewModel: AddSavingsTransactionViewModel(
                id: savingsId,
                currency: currency,
                appState: appState,
                service: AddSavingsTransactionDataService(
                    appState: appState,
                    transactionsRepository: FirebaseSavingsTransactionRepository(),
                    savingsRepository: FirebaseSavingsRepository()
                )
            )
        )
    }

    var depositsTabProvider: TabViewProvider {
        return TabViewProvider(
            systemImageName: "building.columns.fill",
            tabName: "Deposits"
        ) {
            return AnyView(DepositsListView(
                viewModel: DepositsListViewModel(appState: appState),
                depositDetailsViewProvider: { id in depositsDetails(id: id) },
                addDepositViewProvider: { addDepositView() }
            ))
        }
    }

    func addDepositView() -> some View {
        AddDepositView(viewModel: AddDepositViewModel(
            appState: appState,
            service: AddDepositDataService(appState: appState, depositRepository: FirebaseDepositRepository()))
        )
    }

    func depositsDetails(id: String) -> some View {
        DepositDetailsView(
            viewModel: DepositDetailsViewModel(id: id, appState: appState, dataService: DepositDataService(appState: appState, depositStepRepository: FirebaseDepositStepRepository(), depositRepository: FirebaseDepositRepository())),
            editDepositViewProvider: { id in editDeposit(id: id) },
            addDepositStepViewProvider: { id in addDepositStep(depositId: id) }
        )
    }

    func editDeposit(id: String) -> some View {
//        EditDepositView(
//            viewModel: EditDepositViewModel(
//                id: id,
//                appState: appState,
//                service: EditDepositDataService(
//                    appState: appState,
//                    depositRepository: FirebaseDepositRepository()
//                )
//            )
//        )
        return Text("Edit Deposit: \(id)")
    }

    func addDepositStep(depositId: String) -> some View {
        AddDepositStepView(
            viewModel: AddDepositStepViewModel(
                id: depositId,
                dataService: AddDepositStepDataService(
                    appState: appState,
                    depositStepRepository: FirebaseDepositStepRepository(),
                    depositRepository: FirebaseDepositRepository()
                )
            )
        )
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
                viewModel: GoalsListViewModel(appState: appState),
                goalDetailsViewProvider: { id in goalDetails(id: id) },
                addGoalViewProvider: { addGoalView() }
            ))
        }
    }

    func addGoalView() -> some View {
        AddGoalView(viewModel: AddGoalViewModel(
            appState: appState,
            service: AddGoalDataService(appState: appState, goalRepository: FirebaseGoalRepository()))
        )
    }

    func goalDetails(id: String) -> some View {
        GoalDetailsView(
            viewModel: GoalDetailsViewModel(
                id: id,
                appState: appState,
                dataService: GoalDataService(
                    appState: appState,
                    goalStepRepository: FirebaseGoalStepRepository(),
                    goalRepository: FirebaseGoalRepository()
                )
            ),
            editGoalViewProvider: { id in editGoal(id: id) },
            addGoalStepViewProvider: { id in addGoalStep(goalId: id) },
            editGoalStepViewProvider: { step, goalId in editGoalStep(step: step, goalId: goalId) }
        )
    }

    func editGoal(id: String) -> some View {
        EditGoalView(
            viewModel: EditGoalViewModel(
                id: id,
                appState: appState,
                service: EditGoalDataService(
                    appState: appState,
                    goalRepository: FirebaseGoalRepository()
                )
            )
        )
    }

    func addGoalStep(goalId: String) -> some View {
        AddGoalStepView(
            viewModel: AddGoalStepViewModel(
                id: goalId,
                dataService: AddGoalStepDataService(
                    appState: appState,
                    goalStepRepository: FirebaseGoalStepRepository(),
                    goalRepository: FirebaseGoalRepository()
                )
            )
        )
    }

    func editGoalStep(step: GoalStepDVO, goalId: String) -> some View {
        EditGoalStepView(
            viewModel: EditGoalStepViewModel(
                step: step,
                goalId: goalId,
                dataService: EditGoalStepDataService(
                    appState: appState,
                    goalStepRepository: FirebaseGoalStepRepository(),
                    goalRepository: FirebaseGoalRepository()
                )
            )
        )
    }

}
