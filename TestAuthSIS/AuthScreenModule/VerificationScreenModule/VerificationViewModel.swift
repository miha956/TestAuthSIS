//
//  VerificationViewModel.swift
//  TestAuthSIS
//
//  Created by Миша Вашкевич on 03.06.2024.
//

import Foundation

protocol VerificationViewModelProtocol {
    func getViewData() -> (verificationTitle: String, description: String, resendSmsDescription: String, didNotReceiveCodeButtonTitle: String, title: String)
    func checkCode(code: String, complition: (Result<String,Error>) -> Void)
    var codeLenght: Int {get}
    var coordinator: VerifyCoordinator? {get}
}

final class VerificationViewModel: VerificationViewModelProtocol {
    var coordinator: VerifyCoordinator?
    var authState: AuthFlow
    let verificationModel = VerificationModel()
    var codeLenght: Int {
        verificationModel.codeLength
    }
    
    
    func getViewData() -> (verificationTitle: String, description: String, resendSmsDescription: String, didNotReceiveCodeButtonTitle: String, title: String) {
        
        var title = ""
        switch authState {
        case .registration:
            title = verificationModel.registrationTitle
        case .logIn:
            title = verificationModel.logInTitle
        }
        
        return (verificationTitle: verificationModel.verificationTitle, description: verificationModel.description, resendSmsDescription: verificationModel.resendSmsDescription, didNotReceiveCodeButtonTitle: verificationModel.didNotReceiveCodeButtonTitle, title: title)
    }
    
    func checkCode(code: String, complition: (Result<String, Error>) -> Void) {
        let codeToCheck = "123456"
        
        if code == codeToCheck {
            coordinator?.setUpPassCode()
            complition(.success("Code is correct"))
        } else {
            let error = NSError(domain: "CodeErrorDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "Incorrect code"])
            complition(.failure(error))
            
        }
    }
    
    init(authState: AuthFlow) {
        self.authState = authState
    }
}
