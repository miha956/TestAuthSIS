//
//  CodeVerifyView.swift
//  TestAuthSIS
//
//  Created by Миша Вашкевич on 03.06.2024.
//

import UIKit

protocol CodeVerifyViewDelegate: AnyObject {
    func codeIsFull()
    func codeIsntFull()
}

final class CodeVerifyView: UIView {

    weak var codeVerifyViewDelegate: CodeVerifyViewDelegate?
    
    var codeLenght: Int = 0
    
    let fieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 7
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    var codeVerifyfields = [CodeVerifyTextField()]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    init(frame: CGRect, codeLenght: Int) {
        self.codeLenght = codeLenght
        super.init(frame: frame)
        configCodeVerifyView()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit{
        print("CodeVerifyView deinit")
    }
    
    func getCode() -> String {
        var code = ""
        codeVerifyfields.forEach { code.append($0.text ?? "")}
        codeVerifyfields.forEach { $0.text = ""}
        return code
    }
    
    private func configCodeVerifyView() {
        for number in 1...codeLenght {
            let codeVerifyfield = CodeVerifyTextField()
            codeVerifyfield.tag = number
            codeVerifyfield.verifyTextFieldDelegate = self
            codeVerifyfields.append(codeVerifyfield)
            fieldsStackView.addArrangedSubviews(codeVerifyfield)
        }
        addSubViews(fieldsStackView)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            fieldsStackView.topAnchor.constraint(equalTo: topAnchor),
            fieldsStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            fieldsStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            fieldsStackView.bottomAnchor.constraint(equalTo: bottomAnchor),

        ])
    }
}
    //MARK: VerifyTextFieldDelegate

extension CodeVerifyView: VerifyTextFieldDelegate {
    
    func appointNextField(tag: Int) {
        if tag != codeVerifyfields.count - 1 {
            codeVerifyfields[tag + 1].becomeFirstResponder()
        } else {
            codeVerifyViewDelegate?.codeIsFull()
        }
    }
    
    func appointPreviousField(tag: Int) {
        if tag != 0 {
            codeVerifyViewDelegate?.codeIsntFull()
            codeVerifyfields[tag - 1].text = ""
            codeVerifyfields[tag - 1].becomeFirstResponder()
        }
    }
}
