//
//  LogInViewController.swift
//  TestAuthSIS
//
//  Created by Миша Вашкевич on 03.06.2024.
//

import UIKit

final class AuthViewController: UIViewController {
    
    //MARK: Properties
    
    private var viewModel: AuthViewModelProtocol
    
    //MARK: SubViews
    private let authTitle: UILabel = {
        let label = UILabel()
        label.textColor = .appWhite
        return label
    }()
    private lazy var countryCodeTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "+7",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.font = .systemFont(ofSize: 18)
        textField.textColor = .appWhite
        textField.tintColor = .appWhite
        textField.inputView = codePicker
        let imageView = UIImageView(image: UIImage(systemName: "arrowtriangle.down.fill"))
        textField.rightView = imageView
        textField.rightViewMode = .always
        return textField
    }()
    private let countryCodeView: UIView = {
        let view = UIView()
        
        return view
    }()
    private lazy var phoneNumderTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .appWhite
        textField.attributedPlaceholder = NSAttributedString(string: "Введите номер телефона",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.keyboardType = .numberPad
        textField.addTarget(self, action: #selector(numberChanged), for: .editingChanged)
        return textField
    }()
    private let phoneNubmerView: UIView = {
        let view = UIView()
        
        return view
    }()
    private let authDescription: UILabel = {
        let label = UILabel()
        label.textColor = .appWhite
        label.textAlignment = .center
        return label
    }()
    private lazy var getSmsCodeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.appWhite, for: .normal)
        button.addTarget(self, action: #selector(getSmsCodeButtonTapped), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    private lazy var codePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        picker.selectRow(0, inComponent: 0, animated: true)
        return picker
    }()
    
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutViewGradientBorder(view: countryCodeView, cornerRadius: 10, lineWidth: 2)
        layoutViewGradientBorder(view: phoneNubmerView, cornerRadius: 10, lineWidth: 2)
        layoutButton(button: getSmsCodeButton)
    }
    
    init(viewModel: AuthViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    
    @objc func getSmsCodeButtonTapped() {
        viewModel.coordinator?.getSms()
    }
    
    @objc func numberChanged(sender: UITextField) {
        guard let text = sender.text else { return }
        
        if text.count != 0 {
            getSmsCodeButton.isHidden = false
        } else {
            getSmsCodeButton.isHidden = true
        }
    }
    
    private func setupView() {
        
        view.backgroundColor = .appBackground
        
        countryCodeView.addSubViews(countryCodeTextField)
        NSLayoutConstraint.activate([
            countryCodeTextField.centerXAnchor.constraint(equalTo: countryCodeView.centerXAnchor),
            countryCodeTextField.centerYAnchor.constraint(equalTo: countryCodeView.centerYAnchor),
            countryCodeTextField.heightAnchor.constraint(equalToConstant: 25),
            countryCodeTextField.leadingAnchor.constraint(equalTo: countryCodeView.leadingAnchor, constant: 13),
            countryCodeTextField.trailingAnchor.constraint(equalTo: countryCodeView.trailingAnchor, constant: -13),
        ])
        
        phoneNubmerView.addSubViews(phoneNumderTextField)
        NSLayoutConstraint.activate([
            phoneNumderTextField.centerXAnchor.constraint(equalTo: phoneNubmerView.centerXAnchor),
            phoneNumderTextField.centerYAnchor.constraint(equalTo: phoneNubmerView.centerYAnchor),
            phoneNumderTextField.heightAnchor.constraint(equalToConstant: 25),
            phoneNumderTextField.leadingAnchor.constraint(equalTo: phoneNubmerView.leadingAnchor, constant: 13),
            phoneNumderTextField.trailingAnchor.constraint(equalTo: phoneNubmerView.trailingAnchor, constant: -13),
        ])
        
        view.addSubViews(authTitle,
                         countryCodeView,
                         phoneNubmerView,
                         authDescription,
                         getSmsCodeButton)
        
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            authTitle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 33),
            authTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34),
            authTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -34),
            
            countryCodeView.topAnchor.constraint(equalTo: authTitle.bottomAnchor, constant: 15),
            countryCodeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34),
            countryCodeView.heightAnchor.constraint(equalToConstant: 50),
            countryCodeView.widthAnchor.constraint(equalToConstant: 90),
            
            phoneNubmerView.topAnchor.constraint(equalTo: authTitle.bottomAnchor, constant: 15),
            phoneNubmerView.leadingAnchor.constraint(equalTo: countryCodeView.trailingAnchor, constant: 18),
            phoneNubmerView.heightAnchor.constraint(equalToConstant: 50),
            phoneNubmerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -34),
            
            authDescription.topAnchor.constraint(equalTo: phoneNubmerView.bottomAnchor, constant: 22),
            authDescription.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            getSmsCodeButton.topAnchor.constraint(equalTo: authDescription.bottomAnchor, constant: 50),
            getSmsCodeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            getSmsCodeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            getSmsCodeButton.heightAnchor.constraint(equalToConstant: 50)

            
        ])
    }
    
    private func configView() {
        let data = viewModel.getViewData()
        authTitle.text = data.authTitle
        authDescription.text = data.authDescription
        getSmsCodeButton.setTitle(data.buttonTitle, for: .normal)
        title = data.title
    }

}

    //MARK: UIPickerViewDelegate&UIPickerViewDataSource

extension AuthViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.numberOfCountryCodes
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.getCountryCode(row: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        countryCodeTextField.text = viewModel.getSelectedCode(row: row)
    }
}
