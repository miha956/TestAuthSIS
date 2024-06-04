//
//  DotCodeStackView.swift
//  TestAuthSIS
//
//  Created by Миша Вашкевич on 04.06.2024.
//

import UIKit

class DotsCodeView: UIView {

    var codeLenght: Int = 0
    
    private let codeStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = 20
        view.alignment = .center
        view.distribution = .fillEqually
        return view
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
        layer.cornerRadius = frame.height/2
        clipsToBounds = true
        layoutViewGradientBorder(view: self, cornerRadius: 3.71, lineWidth: 0.93)
    }
    
    private func configView() {
        addSubViews(codeStackView)
        
        for num in 0...codeLenght - 1 {
            let view = UIView()
            view.heightAnchor.constraint(equalToConstant: 20).isActive = true
            view.widthAnchor.constraint(equalToConstant: 20).isActive = true
            view.layer.cornerRadius = 10
            view.backgroundColor = .appGray
            codeStackView.addArrangedSubviews(view)
        }
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
        codeStackView.topAnchor.constraint(equalTo: topAnchor),
        codeStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
        codeStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        codeStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])

    }
    
}
