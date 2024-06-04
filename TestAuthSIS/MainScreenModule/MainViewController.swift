//
//  ViewController.swift
//  TestAuthSIS
//
//  Created by Миша Вашкевич on 31.05.2024.
//

import UIKit

final class MainViewController: UIViewController {

    //MARK: Properties
    
    var viewModel: MainViewModelProtocol
    
    //MARK: SubViews
    
    private let companyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let companyNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .appWhite
        label.font = .systemFont(ofSize: 34)
        return label
    }()
    private let motoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .appWhite
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    private let logInButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .appWhite
        button.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
        return button
    }()
    private let noAccountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .appWhite
        label.textAlignment = .center
        return label
    }()
    private lazy var singUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .appBlue
        button.addTarget(self, action: #selector(singUpButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        configView()
    }
    
    init(viewModel: MainViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutButton(button: logInButton)

    }
    
    //MARK: Methods
    
    @objc func singUpButtonTapped() {
        viewModel.coordinator?.singUp()
    }
    @objc func logInButtonTapped() {
        viewModel.coordinator?.logIn()
    }
    
    private func setupView() {
        view.backgroundColor = .appBackground
        
        view.addSubViews(companyImageView,
                         companyNameLabel,
                         motoLabel,
                         logInButton,
                         noAccountLabel,
                         singUpButton)
        
        NSLayoutConstraint.activate([
            companyImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            companyImageView.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: 250),
            companyImageView.heightAnchor.constraint(equalToConstant: 79),
            companyImageView.widthAnchor.constraint(equalToConstant: 79),
            
            companyNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            companyNameLabel.topAnchor.constraint(equalTo: companyImageView.bottomAnchor, constant: 31),
            
            motoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            motoLabel.topAnchor.constraint(equalTo: companyNameLabel.bottomAnchor, constant: 17),
            motoLabel.bottomAnchor.constraint(equalTo: logInButton.topAnchor, constant: -100),
            
            logInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logInButton.bottomAnchor.constraint(equalTo: noAccountLabel.topAnchor, constant: -100),
            logInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            logInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            logInButton.heightAnchor.constraint(equalToConstant: 56),
            
            noAccountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noAccountLabel.bottomAnchor.constraint(equalTo: singUpButton.topAnchor, constant: -10),
            noAccountLabel.leadingAnchor.constraint(lessThanOrEqualTo: view.leadingAnchor, constant: 100),
            noAccountLabel.trailingAnchor.constraint(greaterThanOrEqualTo: view.trailingAnchor, constant: -100),
            
            singUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            singUpButton.leadingAnchor.constraint(lessThanOrEqualTo: view.leadingAnchor, constant: 100),
            singUpButton.trailingAnchor.constraint(greaterThanOrEqualTo: view.trailingAnchor, constant: -100),
            singUpButton.heightAnchor.constraint(equalToConstant: 20),
            singUpButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
    }
    
    private func configView() {
        let data = viewModel.getViewData()
        companyImageView.image = data.companyLogo
        companyNameLabel.text = data.companyName
        motoLabel.text = data.moto
        logInButton.setTitle(data.logInButtonTitle, for: .normal)
        noAccountLabel.text = data.noAccountTitle
        singUpButton.setTitle(data.singUpButtonTitle, for: .normal)
    }

}

