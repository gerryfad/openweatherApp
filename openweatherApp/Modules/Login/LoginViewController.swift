//
//  LoginViewController.swift
//  openweather
//
//  Created by Gerry on 05/03/25.
//

import UIKit
import RxSwift
import RxCocoa
import MBProgressHUD
import CoreLocation

class LoginViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let locationManager = CLLocationManager()
    
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
        button.setTitle("Login", for: .normal)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray5
        locationManager.requestWhenInUseAuthorization()
        
        self.view.addSubview(containerView)
        containerView.addArrangedSubViews(views: [imageViewIcon,usernameTextField,passwordTextField,editButton])
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
        
        if UserPreferenceManager.shared.username == username && UserPreferenceManager.shared.password == password {
            loginSuccess()
        } else {
            let alert = UIAlertController(title: "Error", message: "Username atau Password Salah", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }
    
    private func loginSuccess() {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = "Loading..."
        hud.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first(where: { $0.isKeyWindow }) else {
                return
            }
            
            window.rootViewController?.dismiss(animated: false, completion: nil)
            window.rootViewController = ViewController()
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
            MBProgressHUD.hide(for: self.view, animated: true)

        }
        
    }
}
