//
//  RegisterViewController.swift
//  MovieList
//
//  Created by wyn on 2023/1/29.
//

import UIKit

final class RegisterViewController: UIViewController, Alertable, Loadingable {
    enum RegisterViewString: LocalizedStringType {
        case title
    }
    @IBOutlet weak private var emailTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
    private let viewModel: RegisterViewModelType

    init(viewModel: RegisterViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = RegisterViewString.title.text
        bind(to: viewModel)
    }

    private func bind(to viewModel: RegisterViewModelType) {
        viewModel.error.observe(on: self) {[weak self] in self?.showError($0) }
        viewModel.status.observe(on: self) { [weak self] in self?.toggleSpinner($0) }
    }

    private func showError(_ error: String) {
        guard !error.isEmpty else { return }
        showAlert(style: .alert, title: viewModel.errorTitle, message: error, cancel: CommonString.ok.text)
    }

    @IBAction private func didSelectRegisterHandler() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else { return }
        let account = AccountValue(email: email, password: password)
        viewModel.didSelectRegister(account)
    }
}
