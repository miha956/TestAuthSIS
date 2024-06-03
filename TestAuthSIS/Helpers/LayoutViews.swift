//
//  ButtonLayout.swift
//  TestAuthSIS
//
//  Created by Миша Вашкевич on 03.06.2024.
//

import Foundation
import UIKit

func layoutButton(button: UIButton) {
    button.layer.cornerRadius = button.frame.height/2
    button.clipsToBounds = true
    button.applyGradient(withColours: [.bGrad1, .bGrad2, .bGrad3, .bGrad4, .bGrad5], gradientOrientation: .topRightBottomLeft)
}

func layoutViewGradientBorder(view: UIView) {
    view.applyBorderGradient(withColours: [.bGrad1, .bGrad2, .bGrad3, .bGrad4, .bGrad5], gradientOrientation: .topRightBottomLeft)
}
