//
//  MainViewCoordinator.swift
//  TestAuthSIS
//
//  Created by Миша Вашкевич on 04.06.2024.
//

import Foundation
import UIKit

class MainViewCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("deinit MainViewCoordinator")
    }
    
    func start() {
        let viewModel = MainViewModel()
        viewModel.coordinator = self
        let viewController = MainViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func logIn() {
        let authViewCoordinator = AuthViewCoordinator(navigationController: navigationController, authFlow: .logIn)
        authViewCoordinator.start()
    }
    func singUp() {
        let authViewCoordinator = AuthViewCoordinator(navigationController: navigationController, authFlow: .registration)
        authViewCoordinator.start()
    }
}
