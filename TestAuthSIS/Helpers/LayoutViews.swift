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

func layoutViewGradientBorder(view: UIView, cornerRadius: CGFloat, lineWidth: CGFloat) {
    view.applyBorderGradient(withColours: [.bGrad1, .bGrad2, .bGrad3, .bGrad4, .bGrad5], gradientOrientation: .topRightBottomLeft, cornerRadius: cornerRadius, lineWidth: lineWidth)
}

func setButtonGradient(view: UIView) {
    view.applyGradient(withColours: [.bGrad1, .bGrad2, .bGrad3, .bGrad4, .bGrad5], gradientOrientation: .topRightBottomLeft)
}

func removeButtonGradient(view: UIView) {
    if view.layer.sublayers?.count == 2 {
        view.layer.sublayers?.remove(at: 0)
    }
}

func setViewGradient(view: UIView) {
    view.layer.cornerRadius = view.frame.height/2
    view.clipsToBounds = true
    view.applyGradient(withColours: [.bGrad1, .bGrad2, .bGrad3, .bGrad4, .bGrad5], gradientOrientation: .topRightBottomLeft)
}

func removeViewGradient(view: UIView) {
    if view.layer.sublayers?.count == 1 {
        view.layer.sublayers?.remove(at: 0)
    }
}
