//
//  LoginViewController.swift
//  MovieList
//
//  Created by wyn on 2023/1/27.
//

import UIKit

final class LoginViewController: UIViewController {
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
    }
    @IBAction private func didSelectLoginHandler() {}
    @IBAction private func didSelectSignUpHandler() {
        viewModel.didSelectRegister()
    }
}
