//
//  UIStackView.swift
//  TestAuthSIS
//
//  Created by Миша Вашкевич on 03.06.2024.
//

import Foundation
import UIKit

extension UIStackView {
    
    func addArrangedSubviews(_ views: UIView...) {
        for i in views {
            i.translatesAutoresizingMaskIntoConstraints = false
            self.addArrangedSubview(i)
        }
    }
}
