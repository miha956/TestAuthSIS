//
//  AppCoordinator.swift
//  TestAuthSIS
//
//  Created by Миша Вашкевич on 04.06.2024.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var window: UIWindow
    var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.navigationBar.tintColor = .appBackground
        navigationController.navigationBar.tintColor = .appWhite
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.appWhite]
        
        return navigationController
    }()
    
    init(window: UIWindow) {
        self.window = window
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }
    
    deinit {
        print("deinit AppCoordinator")
    }
    
    func start() {
        let keychainManager = KeychainManager()
        keychainManager.getPassword { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(_):
                print("UserAlready auth, need show code screen")
            case .failure(_):
                let mainCoordinator = MainViewCoordinator(navigationController: self.navigationController)
                mainCoordinator.start()
            }
            
        }
    }
}
