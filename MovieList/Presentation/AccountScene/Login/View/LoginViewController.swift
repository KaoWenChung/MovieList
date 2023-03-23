//
//  LoginViewController.swift
//  MovieList
//
//  Created by wyn on 2023/1/27.
//

import UIKit

final class LoginViewController: MovieListCustomVC, Alertable, Loadingable {
    enum LoginViewString: LocalizedStringType {
        case title
    }
    @IBOutlet weak private var emailTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
    @IBOutlet weak private var saveMyEmailButton: UIButton!
    @IBOutlet weak private var loginByBioButton: UIButton!
    
    private let viewModel: LoginViewModelType
    
    init(viewModel: LoginViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = LoginViewString.title.text
        bind(to: viewModel)
        viewModel.viewDidLoad()
        initConfigButtons()
        emailTextField.text = viewModel.savedAccount
    }

    private func initConfigButtons() {
        saveMyEmailButton.isSelected = viewModel.isSaveEmail
        loginByBioButton.isSelected = viewModel.isBioLogin
    }

    private func bind(to viewModel: LoginViewModelType) {
        viewModel.error.observe(on: self) { [weak self] in self?.showError($0) }
        viewModel.status.observe(on: self) { [weak self] in self?.toggleSpinner($0) }
    }

    private func showError(_ error: String) {
        guard !error.isEmpty else { return }
        showAlert(style: .alert, title: viewModel.errorTitle, message: error, cancel: CommonString.ok.text)
    }

    @IBAction private func didSelectSaveMyEmail() {
        saveMyEmailButton.isSelected.toggle()
        viewModel.setSaveEamil(saveMyEmailButton.isSelected)
    }
    
    @IBAction private func didSelectLoginByBio() {
        loginByBioButton.isSelected.toggle()
        viewModel.setLoginByBio(loginByBioButton.isSelected)
    }

    @IBAction private func didSelectLoginHandler() {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        let account = AccountValue(email: email, password: password)
        viewModel.didSelectLogin(account)
    }

    @IBAction private func didSelectSignUpHandler() {
        viewModel.didSelectRegister()
    }
}
