//
//  UIViewControllerExt.swift
//  TestAuthSIS
//
//  Created by Миша Вашкевич on 04.06.2024.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String?, preferredStyle: UIAlertController.Style) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        let okAction = UIAlertAction(title: "ok", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}
