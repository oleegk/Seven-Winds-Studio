//
//  LoginViewController.swift
//  Coffee
//
//  Created by Олег Ковалев on 07.02.2024.
//

import UIKit

protocol LoginViewProtocol: AnyObject {
    func alertIncorrectDataEntered()
}


class LoginViewController: UIViewController {
    
    var presenter: LoginPresenterProtocol?
    let service = ServiceLocation()
    
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 41, height: 18))
        label.text = "e-mail"
        label.font = Constants.Fonts.SFUIDisplayThin400_15
        label.textColor = Constants.Colors.brown
        return label
    }()
    
    
    private lazy var emailTextField: UITextField = {
        let view = UITextField()
        view.frame = CGRect(x: 0, y: 0, width: 339, height: 73)
        
        view.layer.borderColor = Constants.Colors.brown.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 23
        view.clipsToBounds = true
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: view.frame.height))
        view.leftView = leftPaddingView
        view.leftViewMode = .always

        let attributedPlaceholder = NSMutableAttributedString(string: "example@example.ru", attributes: [NSAttributedString.Key.foregroundColor: Constants.Colors.lightBrownTwo])

        view.attributedPlaceholder = attributedPlaceholder

        view.contentVerticalAlignment = .center
        view.clearButtonMode = .whileEditing
        view.font = Constants.Fonts.SFUIDisplayThin400_18
        view.keyboardType = .emailAddress
        return view
    }()
    
    
    private lazy var passwordLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 41, height: 18))
        label.text = "Пароль"
        label.font = Constants.Fonts.SFUIDisplayThin400_15
        label.textColor = Constants.Colors.brown
        return label
    }()
    
    
    private lazy var passwordTextField: UITextField = {
        let view = UITextField()
        view.frame = CGRect(x: 0, y: 0, width: 339, height: 73)
        
        view.layer.borderColor = Constants.Colors.brown.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 23
        view.clipsToBounds = true
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: view.frame.height))
        view.leftView = leftPaddingView
        view.leftViewMode = .always

        let attributedPlaceholder = NSMutableAttributedString(string: "******", attributes: [NSAttributedString.Key.foregroundColor: Constants.Colors.lightBrownTwo])

        view.attributedPlaceholder = attributedPlaceholder

        view.contentVerticalAlignment = .center
        view.clearButtonMode = .whileEditing
        view.font = Constants.Fonts.SFUIDisplayThin400_18
        return view
    }()
    
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 338, height: 48))
        button.backgroundColor = Constants.Colors.darkBrown
        button.layer.cornerRadius = 23
        button.clipsToBounds = true
        button.setTitle("Войти", for: .normal)
        button.contentVerticalAlignment = .center
        button.titleLabel?.font = Constants.Fonts.SFUIDisplayBold700_18
        button.setTitleColor(Constants.Colors.lightBrownOne, for: .normal)
        button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBarAndItem()
        setupView()
        moveViewUpAndDown()

    }
    
    
    private func setupNavBarAndItem() {
        let titleLabel = UILabel()
        titleLabel.text = "Вход"
        titleLabel.font = Constants.Fonts.SFUIDisplayBold700_18
        titleLabel.textColor = Constants.Colors.brown

        navigationItem.titleView = titleLabel

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constants.Colors.brown]
        navigationItem.hidesBackButton = true
    }
    
    
    private func setupView() {
        view.backgroundColor = .white

        view.addSubview(emailLabel)
        emailLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(278)
            make.left.equalToSuperview().inset(18)
            make.width.equalTo(50)
            make.height.equalTo(18)
        }
        
        view.addSubview(emailTextField)
        emailTextField.delegate = self
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).inset(-10)
            make.height.equalTo(47)
            make.left.equalToSuperview().inset(18)
            make.right.equalToSuperview().inset(18)
        }
        
        view.addSubview(passwordLabel)
        passwordLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(375)
            make.left.equalToSuperview().inset(18)
            make.width.equalTo(55)
            make.height.equalTo(18)
        }
        
        view.addSubview(passwordTextField)
        passwordTextField.delegate = self
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).inset(-10)
            make.height.equalTo(47)
            make.left.equalToSuperview().inset(18)
            make.right.equalToSuperview().inset(18)
        }
        
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(478)
            make.height.equalTo(48)
            make.left.equalToSuperview().inset(19)
            make.right.equalToSuperview().inset(19)
        }
    }
    
    
    @objc func didTapLoginButton() {
        _ = textFieldShouldEndEditing(emailTextField)
        _ = textFieldShouldEndEditing(passwordTextField)
        presenter?.didTapLoginButton()
    }
    
    
    func alertIncorrectDataEntered() {
        let alertController = UIAlertController(title: "Неверный Email или пароль", message: "Проверьте введенные данные", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ОК", style: .default) { _ in
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}



extension LoginViewController: LoginViewProtocol {}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            presenter?.emailWasEntered(email: textField.text ?? "")
        default:
            presenter?.passwordWasEntered(password: textField.text ?? "")
        }
        return true
    }
}
