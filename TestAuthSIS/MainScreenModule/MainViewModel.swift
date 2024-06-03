//
//  MainViewModel.swift
//  TestAuthSIS
//
//  Created by Миша Вашкевич on 31.05.2024.
//

import Foundation
import UIKit

protocol MainViewModelProtocol {
    
    func getViewData() -> (companyLogo: UIImage, companyName: String, moto: String, logInButtonTitle: String, noAccountTitle: String, singUpButtonTitle: String)
}

final class MainViewModel: MainViewModelProtocol {
    
    let model = MainScreenModel()
    
    func getViewData() -> (companyLogo: UIImage, companyName: String, moto: String, logInButtonTitle: String, noAccountTitle: String, singUpButtonTitle: String) {
        return (companyLogo: model.logoImage, companyName: model.companyName, moto: model.moto, logInButtonTitle: model.logInButtonTitle, noAccountTitle: model.noAccountTitle, singUpButtonTitle: model.singUpButtonTitle)
    }

}
