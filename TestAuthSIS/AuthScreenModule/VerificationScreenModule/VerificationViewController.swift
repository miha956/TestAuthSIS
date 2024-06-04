//
//  VerificationViewController.swift
//  TestAuthSIS
//
//  Created by Миша Вашкевич on 03.06.2024.
//

import UIKit

class VerificationViewController: UIViewController {
    
    //MARK: Properties
    
    private var viewModel: VerificationViewModelProtocol
    private var code: [Int] = []
    
    //MARK: SubViews
    private let verificationTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .appWhite
        label.font = .systemFont(ofSize: 24)
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .appGray
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    private let resendSmsDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .appWhite
        return label
    }()
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .appWhite
        label.text = "0:00"
        return label
    }()
    private let resendSmsStackView: UIStackView = {
        let stackView = UIStackView()
        
        return stackView
    }()
    private lazy var codeVerifyView: CodeVerifyView = {
        let verifyView = CodeVerifyView(frame: .zero, codeLenght: viewModel.codeLenght)
        verifyView.codeVerifyViewDelegate = self
        return verifyView
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .appGray
        button.setTitleColor(.appWhite, for: .normal)
        button.isUserInteractionEnabled = false
        button.addTarget(self, action: #selector(confirmCode), for: .touchUpInside)
        return button
    }()
    private let didNotReceiveCodeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.appWhite, for: .normal)
        button.addTarget(self, action: #selector(didNotReceived), for: .touchUpInside)
        return button
    }()
    
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configView()
    }
    
    init(viewModel: VerificationViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        confirmButton.layer.cornerRadius = confirmButton.frame.height/2
        confirmButton.clipsToBounds = true
    }
    
    //MARK: Methods
    
    @objc func confirmCode() {
        viewModel.checkCode(code: codeVerifyView.getCode()) { result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(_):
                showAlert(title: "Ошибка", message: "Код введн некоррено", preferredStyle: .alert)
            }
        }
    }
    
    @objc func didNotReceived() {
        viewModel.coordinator?.codeDidNtRecive()
    }
    
    private func setupView() {
        
        view.backgroundColor = .appBackground
        
        view.addSubViews(verificationTitleLabel,
                         descriptionLabel,
                         resendSmsStackView,
                         codeVerifyView,
                         confirmButton,
                         didNotReceiveCodeButton)
        resendSmsStackView.addArrangedSubviews(resendSmsDescriptionLabel,
                                               timerLabel)
        
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            verificationTitleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 67),
            verificationTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: verificationTitleLabel.bottomAnchor, constant: 18),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 180),
            
            resendSmsStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 35),
            resendSmsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            codeVerifyView.topAnchor.constraint(equalTo: resendSmsStackView.bottomAnchor, constant: 35),
            codeVerifyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 37),
            codeVerifyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -37),
            codeVerifyView.heightAnchor.constraint(equalToConstant: 50),
            
            confirmButton.topAnchor.constraint(equalTo: codeVerifyView.bottomAnchor, constant: 28),
            confirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 37),
            confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -37),
            confirmButton.heightAnchor.constraint(equalToConstant: 50),
            
            didNotReceiveCodeButton.topAnchor.constraint(equalTo: confirmButton.bottomAnchor, constant: 30),
            didNotReceiveCodeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func configView() {
        let data = viewModel.getViewData()
        verificationTitleLabel.text = data.verificationTitle
        descriptionLabel.text = data.description
        resendSmsDescriptionLabel.text = data.resendSmsDescription
        confirmButton.setTitle(data.title, for: .normal)
        title = data.title
        didNotReceiveCodeButton.setTitle(data.didNotReceiveCodeButtonTitle, for: .normal)
    }
}

extension VerificationViewController: CodeVerifyViewDelegate {
    
    func codeIsFull() {
        confirmButton.isUserInteractionEnabled = true
        //setButtonGradient()
        setButtonGradient(view: confirmButton)
        viewDidLayoutSubviews()
    }
    
    func codeIsntFull() {
        confirmButton.isUserInteractionEnabled = false
        //removeButtonGradient()
        removeButtonGradient(view: confirmButton)
        viewDidLayoutSubviews()
    }
}


