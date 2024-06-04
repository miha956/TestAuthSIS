//
//  DidNotGetSmsViewController.swift
//  TestAuthSIS
//
//  Created by Миша Вашкевич on 04.06.2024.
//

import UIKit

class DidNotGetSmsViewController: UIViewController {

    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configVie()
    }
    
    override func viewDidLayoutSubviews() {
        layoutButton(button: button)
    }
    
    private func configVie() {
        
        titleLabel.text = "Не пришел код?"
        titleLabel.textColor = .appWhite
        descriptionLabel.text = "Обратитесь в чат поддержки"
        descriptionLabel.textColor = .appWhite
        
        view.addSubViews(titleLabel, descriptionLabel, button)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            button.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 150),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35)
        
        ])
    }
}
