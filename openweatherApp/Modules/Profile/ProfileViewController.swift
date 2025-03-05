//
//  ProfileViewController.swift
//  openweatherApp
//
//  Created by Gerry on 05/03/25.
//

import UIKit
import XLPagerTabStrip
import RxSwift
import RxCocoa

class ProfileViewController: UIViewController, IndicatorInfoProvider {
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(image: UIImage(systemName: "person.fill"))
    }
    
    private let disposeBag = DisposeBag()
    
    private lazy var containerView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .fill
        view.distribution = .equalSpacing
        view.spacing = 16
        view.setpadding(padding: .init(top: 0, left: 24, bottom: 0, right: 24))
        return view
    }()
    
    private lazy var imageViewIcon: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = nil
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "person")
        view.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return view
    }()
    
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.rx.controlEvent(.editingChanged)
            .subscribe(onNext: { [unowned self] in
                self.setState()
            })
            .disposed(by: disposeBag)
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.rx.controlEvent(.editingChanged)
            .subscribe(onNext: { [unowned self] in
                self.setState()
            })
            .disposed(by: disposeBag)
        return textField
    }()
    
    private lazy var editButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemBlue
        let button = UIButton(configuration: config)
        button.setTitle("Edit", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(editTapped), for: .touchUpInside)
        button.backgroundColor = .lightGray
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .disabled)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.isEnabled = false
        return button
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Logout", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        button.backgroundColor = .white
        button.setTitleColor(.systemBlue, for: .normal)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray5
        
        self.view.addSubview(containerView)
        containerView.addArrangedSubViews(views: [imageViewIcon,usernameTextField,passwordTextField,editButton,logoutButton])
        setupConstraint()
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.pinToSafeArea(containerView, toView: self.view, edges: [.left, .right])
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])

    }
    
    func setState() {
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        if !username.isEmpty && !password.isEmpty {
            editButton.isEnabled = true
        } else {
            editButton.isEnabled = false
        }
    }
    
    @objc func editTapped() {
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        editSuccess(username: username, password: password)

    }
    
    @objc func logoutTapped() {
        logout()
    }
    
    private func editSuccess(username: String, password: String) {
        usernameTextField.text = nil
        passwordTextField.text = nil
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        UserPreferenceManager.shared.username = username
        UserPreferenceManager.shared.password = password
        
        setState()
        
        let alert = UIAlertController(title: "Success", message: "Edit Profile Berhasil", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    private func logout() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first(where: { $0.isKeyWindow }) else {
            return
        }
        
        window.rootViewController?.dismiss(animated: false, completion: nil)
        window.rootViewController = LoginViewController()
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}
