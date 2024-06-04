//
//  CodeVerifyTextField.swift
//  TestAuthSIS
//
//  Created by Миша Вашкевич on 03.06.2024.
//

import UIKit

protocol VerifyTextFieldDelegate: AnyObject {
    func appointNextField(tag: Int)
    func appointPreviousField(tag: Int)
}

final class CodeVerifyTextField: UITextField {

    weak var verifyTextFieldDelegate: VerifyTextFieldDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit{
        print("CodeVerifyTextField deinit")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutViewGradientBorder(view: self, cornerRadius: 3.71, lineWidth: 0.93)
    }
    
    override func deleteBackward() {
        verifyTextFieldDelegate?.appointPreviousField(tag: tag)
    }
    
    private func configView() {
        translatesAutoresizingMaskIntoConstraints = false
        keyboardType = .numberPad
        backgroundColor = .clear
        textColor = .appWhite
        tintColor = .white
        font = .systemFont(ofSize: 28)
        textAlignment = .center
        delegate = self
    }
}
 
    //MARK: UITextFieldDelegate

extension CodeVerifyTextField: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        text = string
        if range.length == 0 {
            verifyTextFieldDelegate?.appointNextField(tag: tag)
            resignFirstResponder()
        }
        return false
    }
}

