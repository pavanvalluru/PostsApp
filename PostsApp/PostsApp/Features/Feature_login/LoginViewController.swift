//
//  LoginViewController.swift
//  PostsApp
//
//  Created by Pavan Kumar Valluru on 13.04.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    private let containerStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .fillProportionally
        return view
    }()

    private let userIdField: UITextField = {
        let field = UITextField()
        field.placeholder = "z.B: \"1\""
        field.returnKeyType = .done
        field.setBottomBorder(with: AppAppearance.Color.ThemeColor)
        return field
    }()

    private let userIdLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "UserID:"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 60).isActive = true
        return label
    }()

    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("LOGIN", for: .normal)
        button.backgroundColor = AppAppearance.Color.ThemeColor
        button.setTitleColor(AppAppearance.Color.TintColor, for: .normal)
        button.addTarget(self, action: #selector(LoginViewController.loginTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let loginViewModel: LoginProvider

    init(viewModel: LoginProvider) {
        self.loginViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupContainerStackView()
        setupLoginButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @objc private func loginTapped() {
        let id = userIdField.text ?? ""
        loginViewModel.login(userId: id, password: nil, onCompletion: {
            // TODO do additional stuff like hiding activity indicator
        })
    }

    // MARK: - view setup

    private func setupContainerStackView() {
        containerStackView.axis = .horizontal
        containerStackView.alignment = .center
        containerStackView.distribution = .fillProportionally
        containerStackView.spacing = 10

        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerStackView)
        NSLayoutConstraint.activate([
            containerStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            containerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

        ])

        containerStackView.addArrangedSubview(userIdLabel)
        userIdField.delegate = self
        containerStackView.addArrangedSubview(userIdField)
    }

    private func setupLoginButton() {
        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: containerStackView.centerXAnchor),
            loginButton.leadingAnchor.constraint(equalTo: containerStackView.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: containerStackView.trailingAnchor),
            loginButton.topAnchor.constraint(equalTo: containerStackView.bottomAnchor, constant: 100)
        ])
    }
}

extension LoginViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
