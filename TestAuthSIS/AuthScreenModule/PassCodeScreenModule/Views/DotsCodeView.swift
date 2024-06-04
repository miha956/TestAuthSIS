//
//  DotCodeStackView.swift
//  TestAuthSIS
//
//  Created by Миша Вашкевич on 04.06.2024.
//

import UIKit

protocol DotsCodeViewDelegate: AnyObject {
    func codeIsFull(code: String)
    func codeIsEditing(code: String)
}

final class DotsCodeView: UIView {

    var codeLenght: Int = 0
    weak var dotsCodeViewDelegate: DotsCodeViewDelegate?
    
    private let codeStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = 20
        view.alignment = .center
        return view
    }()
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.tintColor = .clear
        textField.textColor = .clear
        textField.keyboardType = .numberPad
        textField.addTarget(self, action: #selector(codeChanged), for: .editingChanged)
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(frame: CGRect, codeLenght: Int) {
        self.codeLenght = codeLenght
        super.init(frame: frame)
        
        configView()
        setUpConstraints()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        clipsToBounds = true
        layoutViewGradientBorder(view: self, cornerRadius: frame.height/2, lineWidth: 0.93)
    }
    
    @objc func codeChanged(sender: UITextField) {
        guard let text = sender.text else { return }
        dotsCodeViewDelegate?.codeIsEditing(code: text)
        for subview in codeStackView.subviews {
            removeViewGradient(view: subview)
        }
        for i in 0..<text.count {
            setViewGradient(view: codeStackView.subviews[i])
        }
        
        if text.count >= codeLenght {
            textField.resignFirstResponder()
            guard let code = textField.text else { return }
            dotsCodeViewDelegate?.codeIsFull(code: code)
        }
    }
    
    private func configView() {
        
        backgroundColor = .appViewBackground
        addSubViews(codeStackView, textField)
        
        for num in 0...codeLenght - 1 {
            let view = UIView()
            view.tag = num
            view.heightAnchor.constraint(equalToConstant: 10).isActive = true
            view.widthAnchor.constraint(equalToConstant: 10).isActive = true
            view.layer.cornerRadius = 5
            view.backgroundColor = .appGray
            codeStackView.addArrangedSubviews(view)
        }
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
        
        textField.topAnchor.constraint(equalTo: topAnchor),
        textField.leadingAnchor.constraint(equalTo: leadingAnchor),
        textField.trailingAnchor.constraint(equalTo: trailingAnchor),
        textField.bottomAnchor.constraint(equalTo: bottomAnchor),
        codeStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
        codeStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
