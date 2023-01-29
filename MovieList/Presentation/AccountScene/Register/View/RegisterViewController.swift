//
//  RegisterViewController.swift
//  MovieList
//
//  Created by wyn on 2023/1/29.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak private var emailTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
    @IBOutlet weak private var confirmPasswordTextField: UITextField!
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

        // Do any additional setup after loading the view.
    }

    @IBAction private func didSelectRegisterHandler() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else { return }
        let account = AccountValue(email: email, password: password)
        viewModel.register(account)
    }
}
