//
//  VerifyCoordinator.swift
//  TestAuthSIS
//
//  Created by Миша Вашкевич on 04.06.2024.
//

import Foundation
import UIKit

class VerifyCoordinator: Coordinator {
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
        let viewModel = VerificationViewModel(authState: authState)
        viewModel.coordinator = self
        let viewController = VerificationViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func setUpPassCode() {
        let viewModel = PassCodeViewModel()
        viewModel.coordinator = self
        let viewController = PassCodeViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func codeDidNtRecive() {
        let viewController = DidNotGetSmsViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func codeCreated() {
        let viewController = CodeCreatedUIViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
}

