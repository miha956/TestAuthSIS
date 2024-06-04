//
//  VerificationModel.swift
//  TestAuthSIS
//
//  Created by Миша Вашкевич on 03.06.2024.
//

import Foundation

struct VerificationModel {
    let verificationTitle: String = "Верификация"
    let description: String = "Введите код из смс что мы отправили вам"
    let resendSmsDescription: String = "Запросить код можно через: "
    let didNotReceiveCodeButtonTitle: String = "Я не получил код!"
    let codeLength: Int = 6
    let logInTitle = "Войти"
    let registrationTitle = "Зарегистрироваться"
}
