//
//  PassCodeViewController.swift
//  TestAuthSIS
//
//  Created by Миша Вашкевич on 04.06.2024.
//

import UIKit

class PassCodeViewController: UIViewController {
    
    //MARK: Properties
    
    var viewModel: PassCodeViewModelProtocol
    
    //MARK: SubViews
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .appWhite
        label.font = .systemFont(ofSize: 24)
        label.text = "Создайте код приложения"
        label.textAlignment = .center
        return label
    }()
    private let passcodeStateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .appGray
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Введите код"
        return label
    }()
    private lazy var dotsCodeView: DotsCodeView = {
        let dotsCodeView = DotsCodeView(frame: .zero, codeLenght: 4)
        dotsCodeView.dotsCodeViewDelegate = self
        return dotsCodeView
    }()
    private lazy var skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .appGray
        button.setTitleColor(.appWhite, for: .normal)
        button.setTitle("Пропустить", for: .normal)
        return button
    }()
    
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    init(viewModel: PassCodeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        layoutButton(button: skipButton)
    }
    
    //MARK: Methods
    
    private func configView() {
        view.backgroundColor = .appBackground
        view.addSubViews(titleLabel,passcodeStateLabel,dotsCodeView,skipButton)

        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 75),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),

            passcodeStateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 45),
            passcodeStateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        
            dotsCodeView.topAnchor.constraint(equalTo: passcodeStateLabel.bottomAnchor, constant: 35),
            dotsCodeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dotsCodeView.heightAnchor.constraint(equalToConstant: 50),
            dotsCodeView.widthAnchor.constraint(equalToConstant: 180),
            
            skipButton.topAnchor.constraint(equalTo: dotsCodeView.bottomAnchor, constant: 75),
            skipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            skipButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}

extension PassCodeViewController: DotsCodeViewDelegate {
    func codeIsEditing(code: String) {
        if code.count > 0 {
            skipButton.isHidden = true
        } else {
            skipButton.isHidden = false
        }
    }
    
    func codeIsFull(code: String) {
        viewModel.savePasscode(code: code)
    }
}
