//
//  PassCodeViewModel.swift
//  TestAuthSIS
//
//  Created by Миша Вашкевич on 04.06.2024.
//

import Foundation

protocol PassCodeViewModelProtocol {
    func savePasscode(code: String)
}

final class PassCodeViewModel: PassCodeViewModelProtocol {
    
    let keychainManager = KeychainManager()
    var coordinator: VerifyCoordinator?
    
    func savePasscode(code: String) {
        keychainManager.savePassword(code: code)
        print("save \(code)")
        coordinator?.codeCreated()
    }
    
}
