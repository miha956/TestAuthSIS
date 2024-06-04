//
//  AuthViewModel.swift
//  TestAuthSIS
//
//  Created by Миша Вашкевич on 03.06.2024.
//

import Foundation

protocol AuthViewModelProtocol {
    
    func getViewData() -> (authTitle: String, authDescription: String, buttonTitle: String, title: String)
    func getCountryCode(row: Int) -> String?
    func getSelectedCode(row: Int) -> String?
    var numberOfCountryCodes: Int {get}
    var coordinator: AuthViewCoordinator? {get}
}


final class AuthViewModel: AuthViewModelProtocol {
    var authState: AuthFlow
    var coordinator: AuthViewCoordinator?
    let authModel = AuthScreenModel()
    var countryCodes: [[String]] {
        getAllCountryCodes()
    }
    
    var numberOfCountryCodes: Int {
        return authModel.codePrefixes.count
    }
    
    func getViewData() -> (authTitle: String, authDescription: String, buttonTitle: String, title: String) {
        
        var title = ""
        switch authState {
        case .registration:
            title = authModel.registrationTitle
        case .logIn:
            title = authModel.logInTitle
        }
        
        return (authTitle: authModel.authTitle, authDescription: authModel.authDescription, buttonTitle: authModel.buttonTitle, title: title)
    }
    
    func getCountryCode(row: Int) -> String? {
        let code = countryCodes[row]
        return "\(code[0]) +\(code[1])"
    }
    func getSelectedCode(row: Int) -> String? {
        let code = countryCodes[row]
        return "+\(code[1])"
    }
    
    private func getAllCountryCodes() -> [[String]] {
        var countrys = [[String]]()
        let countryList = authModel.codePrefixes
        for item in countryList {
            countrys.append(item.value)
        }
        let sorted = countrys.sorted(by: {$0[0] < $1[0]})
        return sorted
    }
    
    init(authState: AuthFlow) {
        self.authState = authState
    }
}
