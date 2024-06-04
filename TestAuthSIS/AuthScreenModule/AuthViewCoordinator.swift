//
//  AuthViewCoordinator.swift
//  TestAuthSIS
//
//  Created by Миша Вашкевич on 04.06.2024.
//

import Foundation

import Foundation
import UIKit

enum AuthFlow {
    case registration
    case logIn
}

class AuthViewCoordinator: Coordinator {
    var authState: AuthFlow
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController, authFlow: AuthFlow) {
        self.navigationController = navigationController
        self.authState = authFlow
    }
    
    deinit {
        print("deinit AuthViewCoordinator")
    }
    
    func start() {
        let viewModel = AuthViewModel(authState: authState)
        viewModel.coordinator = self
        let viewController = AuthViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func getSms() {
        let vefufyCoordinator = VerifyCoordinator(navigationController: navigationController, authFlow: authState)
        vefufyCoordinator.start()
    }
}
