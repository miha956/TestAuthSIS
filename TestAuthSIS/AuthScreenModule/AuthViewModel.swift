//
//  AuthViewModel.swift
//  TestAuthSIS
//
//  Created by Миша Вашкевич on 03.06.2024.
//

import Foundation

protocol AuthViewModelProtocol {
    
    func getViewData() -> (authTitle: String, authDescription: String, buttonTitle: String)
    
    var numberOfCountryCodes: Int {get}
}


final class AuthViewModel: AuthViewModelProtocol {

    let authModel = AuthScreenModel()
    
    var numberOfCountryCodes: Int {
        return authModel.codePrefixes.count
    }
    
    func getViewData() -> (authTitle: String, authDescription: String, buttonTitle: String) {
        return (authTitle: authModel.authTitle, authDescription: authModel.authDescription, buttonTitle: authModel.buttonTitle)
    }
}
