//
//  LoginViewController.swift
//  MovieList
//
//  Created by wyn on 2023/1/27.
//

import UIKit

final class LoginViewController: UIViewController, Alertable {
    enum LoginViewString: LocalizedStringType {
        case title
    }
    @IBOutlet weak private var emailTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
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
        title = LoginViewString.title.text
        bind(to: viewModel)
        tryLoginByBiometricAuthentication()
    }

    private func tryLoginByBiometricAuthentication() {
        guard let email = UserDefaultsHelper.shared.account else { return }
        emailTextField.text = email
        let reason = "Authenticate to login your app"
        BiometricHelper.tryBiometricAuthentication(reason: reason, completion: { result in
            guard result,
            let password = KeychainHelper.readPassword(account: email) else { return }
            
            let account = AccountValue(email: email, password: password)
            self.viewModel.login(account)
        })
    }

    private func bind(to viewModel: LoginViewModelType) {
        viewModel.error.observe(on: self) {[weak self] in self?.showError($0)}
    }

    private func showError(_ error: String) {
        guard !error.isEmpty else { return }
        showAlert(style: .alert, title: viewModel.errorTitle, message: error, cancel: CommonString.ok.text)
    }

    @IBAction private func didSelectLoginHandler() {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        let account = AccountValue(email: email, password: password)
        viewModel.login(account)
        UserDefaultsHelper.shared.account = email
        KeychainHelper.savePassword(password, account: email)
    }

    @IBAction private func didSelectSignUpHandler() {
        viewModel.didSelectRegister()
    }
}
