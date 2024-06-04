//
//  CodeCreatedUIViewController.swift
//  TestAuthSIS
//
//  Created by Миша Вашкевич on 04.06.2024.
//

import UIKit

class CodeCreatedUIViewController: UIViewController {

    let backView = UIView()
    let label = UILabel()
    let button = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    private func configView() {
        view.backgroundColor = .appBackground
        backView.addSubViews(label)
        backView.backgroundColor = .appViewBackground
        label.text = "Вы успешно создали код приложения"
        label.textColor = .appWhite
        button.setTitle("Войти в приложение", for: .normal)
        button.backgroundColor = .appViewBackground
        
        view.addSubViews(backView,button)
        
        NSLayoutConstraint.activate([
            backView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            backView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            backView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            backView.heightAnchor.constraint(equalToConstant: 100),
            
            label.centerXAnchor.constraint(equalTo: label.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            
            button.topAnchor.constraint(equalTo: backView.bottomAnchor, constant: 20),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            button.heightAnchor.constraint(equalToConstant: 80)
            
        
        ])
    }

}
